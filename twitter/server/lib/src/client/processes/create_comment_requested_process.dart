import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart';
import 'package:xid/xid.dart';

part 'create_comment_requested_process.g.dart';

/// {@category Process}
///
/// Handles the business process for creating a new comment.
///
/// Flow:
/// 1. Sends 'ModerateText' to ContentModerationService.
/// 2. Waits for 'TextModerationCompleted'.
/// 3. Returns error if text did not pass moderation.
/// 4. Sends 'CreateComment' command to the CommentEntity.
/// 5. Waits for 'CommentCreated' event.
/// 6. Sends 'AddTweetComment' command to the TweetEntity (if parentTweetId is provided).
/// 7. Waits for 'TweetCommentAdded' event.
/// 8. Completes the process.
Future<FlowResult> clientCreateCommentRequested(
  ClientCreateCommentRequested event,
  ProcessContext context,
) async {
  if (event.parentTweetId.isEmpty) {
    return FlowResult.error('parent tweet id can not be empty');
  }

  final result = await context.callService(
    name: 'ContentModerationService',
    cmd: ModerateText(event.text),
    fac: TextModerationCompleted.fromJson,
  );

  if (!result.isValid) {
    return FlowResult.error('text did not pass moderation');
  }

  final commentId = Xid().toString();

  await context.callEntity<CommentCreated>(
    name: 'CommentEntity',
    id: commentId,
    cmd: CreateComment(
      context.senderId!,
      event.text,
      event.parentTweetId,
      event.parentCommentId,
    ),
    fac: CommentCreated.fromJson,
  );

  await context.callEntity<TweetCommentAdded>(
    name: 'TweetEntity',
    id: event.parentTweetId,
    cmd: AddTweetComment(commentId),
    fac: TweetCommentAdded.fromJson,
  );

  if (event.parentCommentId != null && event.parentCommentId!.isNotEmpty) {
    await context.callEntity<CommentReplyAdded>(
      name: 'CommentEntity',
      id: event.parentCommentId!,
      cmd: AddCommentReply(commentId),
      fac: CommentReplyAdded.fromJson,
    );
  }

  return FlowResult.ok(commentId);
}

/// {@category Client Event}
@JsonSerializable()
class ClientCreateCommentRequested extends RemoteEvent {
  ClientCreateCommentRequested({
    required this.text,
    required this.parentTweetId,
    this.parentCommentId,
  });

  /// Text content of the comment
  final String text;

  /// ID of the parent tweet (required)
  final String parentTweetId;

  /// ID of the parent comment (optional, for replies to comments)
  final String? parentCommentId;

  factory ClientCreateCommentRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientCreateCommentRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientCreateCommentRequestedToJson(this);
  }
}
