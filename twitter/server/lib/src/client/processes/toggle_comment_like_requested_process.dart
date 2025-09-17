import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart'; // Import twitter_server.dart

part 'toggle_comment_like_requested_process.g.dart';

/// {@category Process}
///
/// Handles the ToggleCommentLikeRequested business process.
///
/// 1. Sends a 'ToggleCommentLike' command to the CommentEntity.
/// 2. Waits for the result event: either 'CommentLiked' or 'CommentUnliked'.
/// 3. Ends the process after receiving the outcome.
Future<FlowResult> clientToggleCommentLikeRequested(
  ClientToggleCommentLikeRequested event,
  ProcessContext context,
) async {
  await context.callEntityDynamic(
    name: 'CommentEntity',
    id: event.commentId,
    cmd: ToggleCommentLike(context.senderId),
    fac: [
      CommentLiked.fromJson,
      CommentUnliked.fromJson,
    ],
  );

  return FlowResult.ok();
}

/// {@category Client Event}
@JsonSerializable()
class ClientToggleCommentLikeRequested extends RemoteEvent {
  ClientToggleCommentLikeRequested(this.commentId);

  /// ID of the comment to like or unlike
  String commentId;

  factory ClientToggleCommentLikeRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientToggleCommentLikeRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientToggleCommentLikeRequestedToJson(this);
  }
}
