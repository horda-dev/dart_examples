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
    // TODO: implement CreateTimeline handler
    throw UnimplementedError('CreateTimeline handler is not implemented');
  }

  /// For command description, see [AddTweetToTimeline].
  Future<RemoteEvent> addTweetToTimeline(
    AddTweetToTimeline cmd,
    TimelineEntityState state,
    EntityContext context,
  ) async {
    // TODO: implement AddTweetToTimeline handler
    throw UnimplementedError('AddTweetToTimeline handler is not implemented');
  }

  @override
  void initHandlers(EntityHandlers<TimelineEntityState> handlers) {
    // TODO: uncomment when TimelineEntityState.fromTimelineCreated is implemented
    // handlers.addInit<CreateTimeline, TimelineCreated>(
    //   createTimeline,
    //   CreateTimeline.fromJson,
    //   TimelineEntityState.fromTimelineCreated,
    // );

    handlers.add<AddTweetToTimeline>(
      addTweetToTimeline,
      AddTweetToTimeline.fromJson,
    );
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
