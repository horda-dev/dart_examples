import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart';
import 'package:xid/xid.dart';

part 'create_tweet_requested_process.g.dart';

/// {@category Process}
///
/// Handles the business process for creating a new tweet.
/// 1. Sends 'ModerateText' to ContentModerationService.
/// 2. Waits for 'TextModerationCompleted'.
/// 3. Returns error if text did not pass moderation.
/// 4. Sends 'CreateTweet' to TweetEntity.
/// 5. Waits for 'TweetCreated' event.
/// 6. Sends 'AddTweetToExploreFeed'.
/// 7. Sends 'AddTweetToTimeline' for each timeline id in the client event.
Future<FlowResult> clientCreateTweetRequested(
  ClientCreateTweetRequested event,
  ProcessContext context,
) async {
  final result = await context.callService(
    name: 'ContentModerationService',
    cmd: ModerateText(event.text),
    fac: TextModerationCompleted.fromJson,
  );

  if (!result.isValid) {
    return FlowResult.error('text did not pass moderation');
  }

  final tweetId = Xid().toString();

  await context.callEntity<TweetCreated>(
    name: 'TweetEntity',
    id: tweetId,
    cmd: CreateTweet(
      event.authorUserId,
      event.text,
    ),
    fac: TweetCreated.fromJson,
  );

  context.sendEntity(
    name: 'ExploreFeedEntity',
    id: kExploreFeedEntityId,
    cmd: AddTweetToExploreFeed(tweetId),
  );

  for (final timelineId in event.timelineIds) {
    context.sendEntity(
      name: 'TimelineEntity',
      id: timelineId,
      cmd: AddTweetToTimeline(tweetId),
    );
  }

  return FlowResult.ok();
}

/// {@category Client Event}
@JsonSerializable()
class ClientCreateTweetRequested extends RemoteEvent {
  ClientCreateTweetRequested({
    required this.authorUserId,
    required this.text,
    required this.timelineIds,
  });

  /// ID of the user who authored the tweet
  final String authorUserId;

  /// Text content of the tweet
  final String text;

  /// IDs of timelines in which this tweet will show up
  final List<String> timelineIds;

  factory ClientCreateTweetRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientCreateTweetRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientCreateTweetRequestedToJson(this);
  }
}
