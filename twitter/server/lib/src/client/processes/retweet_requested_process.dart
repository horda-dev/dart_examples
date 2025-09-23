import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart'; // Import twitter_server.dart

part 'retweet_requested_process.g.dart';

/// {@category Process}
///
/// Handles the RetweetRequested business process.
///
/// 1. Sends the 'RetweetTweet' command to the TweetEntity.
/// 2. Waits for the 'TweetRetweeted' event, fails on error.
/// 3. Sends 'AddTweetToTimeLine' for each timeline id in the client event.
Future<FlowResult> clientRetweetRequested(
  ClientRetweetRequested event,
  ProcessContext context,
) async {
  await context.callEntity<TweetRetweeted>(
    name: 'TweetEntity',
    id: event.tweetId,
    cmd: RetweetTweet(
      context.senderId!,
    ),
    fac: TweetRetweeted.fromJson,
  );

  for (final timelineId in event.timelineIds) {
    context.sendEntity(
      name: 'TimelineEntity',
      id: timelineId,
      cmd: AddTweetToTimeline(event.tweetId),
    );
  }

  return FlowResult.ok();
}

/// {@category Client Event}
@JsonSerializable()
class ClientRetweetRequested extends RemoteEvent {
  ClientRetweetRequested(this.tweetId, this.timelineIds);

  /// ID of the tweet to retweet
  String tweetId;

  /// IDs of timelines in which this tweet will show up
  List<String> timelineIds;

  factory ClientRetweetRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientRetweetRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientRetweetRequestedToJson(this);
  }
}
