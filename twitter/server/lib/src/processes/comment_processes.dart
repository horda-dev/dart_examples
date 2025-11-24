import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../../../twitter_server.dart';

class CommentProcesses extends ProcessGroup {
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
  static Future<ProcessResult> createCommentRequested(
    CreateCommentRequested event,
    ProcessContext context,
  ) async {
    if (event.parentTweetId.isEmpty) {
      return ProcessResult.error('parent tweet id can not be empty');
    }

    final result = await context.callService(
      name: 'ContentModerationService',
      cmd: ModerateText(event.text),
      fac: TextModerationCompleted.fromJson,
    );

    if (!result.isValid) {
      return ProcessResult.error('text did not pass moderation');
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

    return ProcessResult.ok(commentId);
  }

  /// {@category Process}
  ///
  /// Handles the ToggleCommentLikeRequested business process.
  ///
  /// 1. Sends a 'ToggleCommentLike' command to the CommentEntity.
  /// 2. Waits for the result event: either 'CommentLiked' or 'CommentUnliked'.
  /// 3. Ends the process after receiving the outcome.
  static Future<ProcessResult> toggleCommentLikeRequested(
    ToggleCommentLikeRequested event,
    ProcessContext context,
  ) async {
    await context.callEntityDynamic(
      name: 'CommentEntity',
      id: event.commentId,
      cmd: ToggleCommentLike(context.senderId!),
      fac: [
        CommentLiked.fromJson,
        CommentUnliked.fromJson,
      ],
    );

    return ProcessResult.ok();
  }

  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs.add<CreateCommentRequested>(
      createCommentRequested,
      CreateCommentRequested.fromJson,
    );
    funcs.add<ToggleCommentLikeRequested>(
      toggleCommentLikeRequested,
      ToggleCommentLikeRequested.fromJson,
    );
  }
}
