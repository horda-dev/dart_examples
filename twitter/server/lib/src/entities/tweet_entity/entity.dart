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
    // TODO: implement CreateTweet handler
    throw UnimplementedError('CreateTweet handler is not implemented');
  }

  /// For command description, see [ToggleTweetLike].
  Future<RemoteEvent> toggleTweetLike(
    ToggleTweetLike cmd,
    TweetEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement ToggleTweetLike handler
    throw UnimplementedError('ToggleTweetLike handler is not implemented');
  }

  /// For command description, see [RetweetTweet].
  Future<RemoteEvent> retweetTweet(
    RetweetTweet cmd,
    TweetEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement RetweetTweet handler
    throw UnimplementedError('RetweetTweet handler is not implemented');
  }

  /// For command description, see [AddTweetComment].
  Future<RemoteEvent> addTweetComment(
    AddTweetComment cmd,
    TweetEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement AddTweetComment handler
    throw UnimplementedError('AddTweetComment handler is not implemented');
  }

  @override
  void initHandlers(EntityHandlers<TweetEntityState> handlers) {
    // TODO: uncomment when TweetEntityState.fromTweetCreated is implemented
    // handlers.addInit<CreateTweet, TweetCreated>(
    //   createTweet,
    //   CreateTweet.fromJson,
    //   TweetEntityState.fromTweetCreated,
    // );

    handlers.add<ToggleTweetLike>(toggleTweetLike, ToggleTweetLike.fromJson);
    handlers.add<RetweetTweet>(retweetTweet, RetweetTweet.fromJson);
    handlers.add<AddTweetComment>(addTweetComment, AddTweetComment.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
