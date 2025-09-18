import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// Represents a single tweet in the system.
///
/// {@category Entity}
class TweetEntity extends Entity<TweetEntityState> {
  Future<TweetCreated> createTweet(
    CreateTweet cmd,
    EntityContext context,
  ) async {
    return TweetCreated(cmd.authorUserId, cmd.text, cmd.attachmentUrl);
  }

  /// For command description, see [ToggleTweetLike].
  Future<RemoteEvent> toggleTweetLike(
    ToggleTweetLike cmd,
    TweetEntityState state,
    EntityContext context,
  ) async {
    if (state.likedByUsers.contains(cmd.userId)) {
      return TweetUnliked(cmd.userId);
    } else {
      return TweetLiked(cmd.userId);
    }
  }

  /// For command description, see [RetweetTweet].
  Future<RemoteEvent> retweetTweet(
    RetweetTweet cmd,
    TweetEntityState state,
    EntityContext context,
  ) async {
    if (state.retweetedByUsers.contains(cmd.userId)) {
      throw TweetEntityException('Tweet already retweeted by this user.');
    }
    return TweetRetweeted(cmd.userId);
  }

  /// For command description, see [AddTweetComment].
  Future<RemoteEvent> addTweetComment(
    AddTweetComment cmd,
    TweetEntityState state,
    EntityContext context,
  ) async {
    return TweetCommentAdded(cmd.commentId);
  }

  @override
  void initHandlers(EntityHandlers<TweetEntityState> handlers) {
    handlers.addStateFromJson(TweetEntityState.fromJson);
    handlers.addInit<CreateTweet, TweetCreated>(
      createTweet,
      CreateTweet.fromJson,
      TweetEntityState.fromTweetCreated,
    );

    handlers.add<ToggleTweetLike>(toggleTweetLike, ToggleTweetLike.fromJson);
    handlers.add<RetweetTweet>(retweetTweet, RetweetTweet.fromJson);
    handlers.add<AddTweetComment>(addTweetComment, AddTweetComment.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}

/// Exception thrown when tweet operations violate business rules.
class TweetEntityException implements Exception {
  /// The error message describing what went wrong.
  final String message;

  /// Creates a new tweet entity exception with the given [message].
  TweetEntityException(this.message);

  @override
  String toString() {
    return 'TweetEntityException: $message';
  }
}
