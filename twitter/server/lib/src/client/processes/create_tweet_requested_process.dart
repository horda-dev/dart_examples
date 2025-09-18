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
/// 4. Sends 'UploadTweetAttachment', if attachment was prodvided, and waits for result
/// 5. Returns error if upload failed.
/// 6. Sends 'CreateTweet' to TweetEntity.
/// 7. Waits for 'TweetCreated' event.
/// 8. Sends 'AddTweetToExploreFeed'.
/// 9. Sends 'AddTweetToTimeline' for each timeline id in the client event.
Future<FlowResult> clientCreateTweetRequested(
  ClientCreateTweetRequested event,
  ProcessContext context,
) async {
  final moderationResult = await context.callService(
    name: 'ContentModerationService',
    cmd: ModerateText(event.text),
    fac: TextModerationCompleted.fromJson,
  );

  if (!moderationResult.isValid) {
    return FlowResult.error('text did not pass moderation');
  }

  final tweetId = Xid().toString();
  var attachmentUrl = '';

  if (event.attachmentBase64 != null) {
    final attachmentResult = await context.callServiceDynamic(
      name: 'MediaStoreService',
      cmd: UploadTweetAttachment(tweetId, event.attachmentBase64!),
      fac: [
        TweetAttachmentUploaded.fromJson,
        TweetAttachmentUploadFailed.fromJson,
      ],
    );

    if (attachmentResult is TweetAttachmentUploadFailed) {
      return FlowResult.error(
        'attachment failed to upload: ${attachmentResult.reason}',
      );
    }

    attachmentResult as TweetAttachmentUploaded;
    attachmentUrl = attachmentResult.attachmentUrl;
  }

  await context.callEntity<TweetCreated>(
    name: 'TweetEntity',
    id: tweetId,
    cmd: CreateTweet(
      event.authorUserId,
      event.text,
      attachmentUrl,
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

  return FlowResult.ok(tweetId);
}

/// {@category Client Event}
@JsonSerializable()
class ClientCreateTweetRequested extends RemoteEvent {
  ClientCreateTweetRequested({
    required this.authorUserId,
    required this.text,
    required this.attachmentBase64,
    required this.timelineIds,
  });

  /// ID of the user who authored the tweet
  final String authorUserId;

  /// Text content of the tweet
  final String text;

  /// An image attached to the tweet, in base64 encoding
  final String? attachmentBase64;

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
