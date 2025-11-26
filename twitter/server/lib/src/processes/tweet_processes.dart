import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import '../entities/explore_feed_entity/messages.dart';
import '../entities/timeline_entity/messages.dart';
import '../entities/tweet_entity/messages.dart';
import '../services/content_moderation_service/messages.dart';
import '../services/user_profile_picture_service/messages.dart';
import 'messages.dart';

class TweetProcesses extends ProcessGroup {
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
  static Future<ProcessResult> createTweetRequested(
    CreateTweetRequested event,
    ProcessContext context,
  ) async {
    final moderationResult = await context.callService(
      name: 'ContentModerationService',
      cmd: ModerateText(event.text),
      fac: TextModerationCompleted.fromJson,
    );

    if (!moderationResult.isValid) {
      return ProcessResult.error('text did not pass moderation');
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
        return ProcessResult.error(
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
      id: kSingletonId,
      cmd: AddTweetToExploreFeed(tweetId),
    );

    for (final timelineId in event.timelineIds) {
      context.sendEntity(
        name: 'TimelineEntity',
        id: timelineId,
        cmd: AddTweetToTimeline(tweetId),
      );
    }

    return ProcessResult.ok(tweetId);
  }

  /// {@category Process}
  ///
  /// Handles the RetweetRequested business process.
  ///
  /// 1. Sends the 'RetweetTweet' command to the TweetEntity.
  /// 2. Waits for the 'TweetRetweeted' event, fails on error.
  /// 3. Sends 'AddTweetToTimeLine' for each timeline id in the client event.
  static Future<ProcessResult> retweetRequested(
    RetweetRequested event,
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

    return ProcessResult.ok();
  }

  /// {@category Process}
  ///
  /// Handles the business process for toggling a like on a Tweet.
  /// 1. Sends the 'ToggleTweetLike' command to the TweetEntity.
  /// 2. Awaits either the 'TweetLiked' or 'TweetUnliked' event to determine the resulting state.
  /// 3. Completes the process when the operation is acknowledged.
  static Future<ProcessResult> toggleTweetLikeRequested(
    ToggleTweetLikeRequested event,
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

    return ProcessResult.ok();
  }

  @override
  void registerFuncs(ProcessFuncs funcs) {
    funcs.add<CreateTweetRequested>(
      createTweetRequested,
      CreateTweetRequested.fromJson,
    );
    funcs.add<RetweetRequested>(
      retweetRequested,
      RetweetRequested.fromJson,
    );
    funcs.add<ToggleTweetLikeRequested>(
      toggleTweetLikeRequested,
      ToggleTweetLikeRequested.fromJson,
    );
  }
}
