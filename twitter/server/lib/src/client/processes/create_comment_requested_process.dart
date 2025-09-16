import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart'; // For CreateComment

part 'create_comment_requested_process.g.dart';

/// {@category Process}
///
/// Handles the business process for creating a new comment.
///
/// Flow:
/// 1. Sends 'CreateComment' command to the CommentEntity.
/// 2. Waits for 'CommentCreated' event.
/// 3. Sends 'AddTweetComment' command to the TweetEntity (if parentTweetId is provided).
/// 4. Waits for 'TweetCommentAdded' event.
/// 5. Completes the process.
Future<FlowResult> clientCreateCommentRequested(
  ClientCreateCommentRequested event,
  ProcessContext context,
) async {
  // TODO: Implement clientCreateCommentRequested
  /*
  // 1. Send 'CreateComment' to CommentEntity
  final commentCreated = await context.callActor(
    name: 'CommentEntity',
    id: context.newId(), // Generate a new ID for the comment
    cmd: CreateComment(
      event.authorUserId,
      event.text,
      event.parentTweetId,
      event.parentCommentId,
    ),
    fac: CommentCreated.fromJson,
  );

  // 2. If parentTweetId is provided, send 'AddTweetComment' to TweetEntity
  if (event.parentTweetId != null && event.parentTweetId.isNotEmpty) {
    await context.callActor(
      name: 'TweetEntity',
      id: event.parentTweetId,
      cmd: AddTweetComment(commentCreated.commentId), // Assuming CommentCreated returns commentId
      fac: TweetCommentAdded.fromJson,
    );
  }

  // TODO: Handle parentCommentId if provided (add reply to comment)

  return FlowResult.ok();
  */
  return FlowResult.error("Unimplemented");
}

/// {@category Client Event}
@JsonSerializable()
class ClientCreateCommentRequested extends RemoteEvent {
  ClientCreateCommentRequested({
    required this.authorUserId,
    required this.text,
    required this.parentTweetId,
    this.parentCommentId,
  });

  /// ID of the user who authored the comment
  final String authorUserId;

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
