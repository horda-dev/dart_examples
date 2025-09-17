import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// The global entity ID used for the explore feed which all users can see.
///
/// This constant defines the single instance ID for the [ExploreFeedEntity]
/// that allows users discover new tweets, even when the user doesn't follow anybody yet.
const kExploreFeedEntityId = 'globalExploreFeedEntityId';

/// Represents an explore feed with trending tweets.
///
/// {@category Entity}
class ExploreFeedEntity extends Entity<ExploreFeedEntityState> {
  Future<ExploreFeedCreated> createExploreFeed(
    CreateExploreFeed cmd,
    EntityContext context,
  ) async {
    // TODO: implement CreateExploreFeed handler
    throw UnimplementedError('CreateExploreFeed handler is not implemented');
  }

  /// For command description, see [AddTweetToExploreFeed].
  Future<RemoteEvent> addTweetToExploreFeed(
    AddTweetToExploreFeed cmd,
    ExploreFeedEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement AddTweetToExploreFeed handler
    throw UnimplementedError(
      'AddTweetToExploreFeed handler is not implemented',
    );
  }

  @override
  void initHandlers(EntityHandlers<ExploreFeedEntityState> handlers) {
    // TODO: uncomment when ExploreFeedEntityState.fromExploreFeedCreated is implemented
    // handlers.addInit<CreateExploreFeed, ExploreFeedCreated>(
    //   createExploreFeed,
    //   CreateExploreFeed.fromJson,
    //   ExploreFeedEntityState.fromExploreFeedCreated,
    // );

    handlers.add<AddTweetToExploreFeed>(
      addTweetToExploreFeed,
      AddTweetToExploreFeed.fromJson,
    );
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
