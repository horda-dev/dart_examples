import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:twitter_server/twitter_server.dart'; // For CreateTweet, TweetCommentAdded

part 'create_tweet_requested_process.g.dart';

/// {@category Process}
///
/// Handles the business process for creating a new tweet.
///
/// Flow:
/// 1. Sends 'CreateTweet' command to the TweetEntity.
/// 2. Waits for 'TweetCreated' event.
/// 3. Sends 'AddTweetToTimeline' command to the TimelineEntity.
/// 4. Waits for 'TweetAddedToTimeline' event.
/// 5. Completes the process.
Future<FlowResult> clientCreateTweetRequested(
  ClientCreateTweetRequested event,
  ProcessContext context,
) async {
  // TODO: Implement clientCreateTweetRequested
  /*
  // 1. Send 'CreateTweet' to TweetEntity
  final tweetCreated = await context.callActor(
    name: 'TweetEntity',
    id: context.newId(), // Generate a new ID for the tweet
    cmd: CreateTweet(
      event.authorUserId,
      event.text,
    ),
    fac: TweetCreated.fromJson,
  );

  // 2. Send 'AddTweetToTimeline' to TimelineEntity
  await context.callActor(
    name: 'TimelineEntity',
    id: event.authorUserId, // Assuming timeline ID is user ID
    cmd: AddTweetToTimeline(tweetCreated.tweetId), // Assuming TweetCreated returns tweetId
    fac: TweetAddedToTimeline.fromJson,
  );

  return FlowResult.ok();
  */
  return FlowResult.error("Unimplemented");
}

/// {@category Client Event}
@JsonSerializable()
class ClientCreateTweetRequested extends RemoteEvent {
  ClientCreateTweetRequested({
    required this.authorUserId,
    required this.text,
  });

  /// ID of the user who authored the tweet
  final String authorUserId;

  /// Text content of the tweet
  final String text;

  factory ClientCreateTweetRequested.fromJson(Map<String, dynamic> json) {
    return _$ClientCreateTweetRequestedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ClientCreateTweetRequestedToJson(this);
  }
}
