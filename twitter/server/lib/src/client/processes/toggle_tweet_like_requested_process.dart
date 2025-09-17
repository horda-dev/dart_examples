import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart'; // Import twitter_server.dart

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
  await context.callEntityDynamic(
    name: 'TweetEntity',
    id: event.tweetId,
    cmd: ToggleTweetLike(
      context.senderId,
    ),
    fac: [
      TweetLiked.fromJson,
      TweetUnliked.fromJson,
    ],
  );

  return FlowResult.ok();
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
