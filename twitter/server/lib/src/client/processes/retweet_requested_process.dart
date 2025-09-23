import 'package:horda_server/horda_server.dart';

import '../../../twitter_server.dart';

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
