import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// Represents a timeline feed for a user.
///
/// {@category Entity}
class TimelineEntity extends Entity<TimelineEntityState> {
  Future<TimelineCreated> createTimeline(
    CreateTimeline cmd,
    EntityContext context,
  ) async {
    return TimelineCreated(cmd.ownerUserId);
  }

  /// For command description, see [AddTweetToTimeline].
  Future<RemoteEvent> addTweetToTimeline(
    AddTweetToTimeline cmd,
    TimelineEntityState state,
    EntityContext context,
  ) async {
    return TweetAddedToTimeline(cmd.tweetId);
  }

  @override
  void initHandlers(EntityHandlers<TimelineEntityState> handlers) {
    handlers.addStateFromJson(TimelineEntityState.fromJson);
    handlers.addInit<CreateTimeline, TimelineCreated>(
      createTimeline,
      CreateTimeline.fromJson,
      (event) => TimelineEntityState(),
    );

    handlers.add<AddTweetToTimeline>(
      addTweetToTimeline,
      AddTweetToTimeline.fromJson,
    );
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
