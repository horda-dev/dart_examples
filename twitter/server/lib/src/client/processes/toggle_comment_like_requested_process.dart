import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

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
  /*
  // Send 'ToggleCommentLike' command to CommentEntity
  final result = await context.callActor<RemoteEvent>(
    name: 'CommentEntity',
    id: event.commentId, // Assuming event has commentId
    cmd: ToggleCommentLike(),
    fac: RemoteEvent.fromJson, // The base type, as outcome is one of two events
  );
  
  // Decision: check if result is 'CommentLiked' or 'CommentUnliked'
  // (Decision logic to be implemented based on the event type or payload)
  */
  // TODO: Implement ToggleCommentLikeRequested
  return FlowResult.error("Unimplemented");
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
