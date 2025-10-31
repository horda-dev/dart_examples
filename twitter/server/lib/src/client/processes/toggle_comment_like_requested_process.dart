import 'package:horda_server/horda_server.dart';

import '../../../twitter_server.dart';

/// {@category Process}
///
/// Handles the ToggleCommentLikeRequested business process.
///
/// 1. Sends a 'ToggleCommentLike' command to the CommentEntity.
/// 2. Waits for the result event: either 'CommentLiked' or 'CommentUnliked'.
/// 3. Ends the process after receiving the outcome.
Future<ProcessResult> clientToggleCommentLikeRequested(
  ClientToggleCommentLikeRequested event,
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
