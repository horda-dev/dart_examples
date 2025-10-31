import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// Represents an explore feed with trending tweets.
///
/// This is a singleton entity, automatically created at deployment time.
///
/// {@category Entity}
class ExploreFeedEntity extends Entity<ExploreFeedEntityState> {
  @override
  ExploreFeedEntityState? get singleton => ExploreFeedEntityState();

  /// For command description, see [AddTweetToExploreFeed].
  Future<RemoteEvent> addTweetToExploreFeed(
    AddTweetToExploreFeed cmd,
    ExploreFeedEntityState state,
    EntityContext context,
  ) async {
    return TweetAddedToExploreFeed(cmd.tweetId);
  }

  @override
  void initHandlers(EntityHandlers<ExploreFeedEntityState> handlers) {
    handlers.addStateFromJson(ExploreFeedEntityState.fromJson);

    handlers.add<AddTweetToExploreFeed>(
      addTweetToExploreFeed,
      AddTweetToExploreFeed.fromJson,
    );
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
