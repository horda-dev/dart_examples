import 'package:horda_server/horda_server.dart';

import '../../../twitter_server.dart';

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
      context.senderId!,
    ),
    fac: [
      TweetLiked.fromJson,
      TweetUnliked.fromJson,
    ],
  );

  return FlowResult.ok();
}
