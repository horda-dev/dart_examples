import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'toggle_tweet_like_requested_process.g.dart';

/// {@category Process}
///
/// Handles the business process for toggling a like on a Tweet.
/// 1. Sends the 'ToggleTweetLike' command to the TweetEntity.
/// 2. Awaits either the 'TweetLiked' or 'TweetUnliked' event to determine the resulting state.
/// 3. Completes the process when the operation is acknowledged.
Future<FlowResult> clientToggleTweetLikeRequested(
  ClientToggleTweetLikeRequested event,
  ProcessContext context,
) async {
  /*
  // Send 'ToggleTweetLike' command to the TweetEntity and await the resulting event.
  // Either 'TweetLiked' or 'TweetUnliked' will be returned (decide based on the event payload if needed).
  final resultEvent = await context.callActor(
    name: 'TweetEntity',
    id: event.tweetId,
    cmd: ToggleTweetLike(),
    fac: TweetLiked.fromJson, // or TweetUnliked.fromJson depending on response
  );
  
  // The operation completes here regardless of which event was emitted.
  */
  // TODO: Implement ToggleTweetLikeRequested
  return FlowResult.error("Unimplemented");
}

/// {@category Client Event}
@JsonSerializable()
class ClientToggleTweetLikeRequested extends RemoteEvent {
  ClientToggleTweetLikeRequested(this.tweetId);

  /// ID of the tweet to like or unlike
  String tweetId;

  factory ClientToggleTweetLikeRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientToggleTweetLikeRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientToggleTweetLikeRequestedToJson(this);
  }
}
