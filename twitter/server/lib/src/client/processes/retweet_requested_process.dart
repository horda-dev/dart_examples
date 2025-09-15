import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'retweet_requested_process.g.dart';

/// {@category Process}
///
/// Handles the RetweetRequested business process.
///
/// 1. Sends the 'RetweetTweet' command to the TweetEntity.
/// 2. Waits for the 'TweetRetweeted' event, then completes the process.
Future<FlowResult> clientRetweetRequested(
  ClientRetweetRequested event,
  ProcessContext context,
) async {
  /*
  // Send 'RetweetTweet' command to TweetEntity and wait for 'TweetRetweeted'
  await context.callActor<TweetRetweeted>(
    name: 'TweetEntity',
    id: event.tweetId,
    cmd: RetweetTweet(),
    fac: TweetRetweeted.fromJson,
  );
  return FlowResult.ok();
  */
  // TODO: Implement RetweetRequested
  return FlowResult.error("Unimplemented");
}

/// {@category Client Event}
@JsonSerializable()
class ClientRetweetRequested extends RemoteEvent {
  ClientRetweetRequested(this.tweetId);

  /// ID of the tweet to retweet
  String tweetId;

  factory ClientRetweetRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientRetweetRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientRetweetRequestedToJson(this);
  }
}
