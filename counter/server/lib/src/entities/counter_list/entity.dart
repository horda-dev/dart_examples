import 'package:horda_server/horda_server.dart';

import 'state.dart';
import 'messages.dart';

/// A Horda entity that manages a list of counter references.
///
/// This entity demonstrates how to manage collections of entity references
/// within the Horda serverless platform. It maintains a list of counter IDs
/// that can be added to or removed from.
///
/// This is a singleton entity, automatically created at deployment time.
///
/// {@category Entity}
class CounterListEntity extends Entity<CounterListState> {
  @override
  CounterListState? get singleton => CounterListState();

  /// Adds a counter reference to the list.
  ///
  /// [command] contains the ID of the counter to add
  /// [state] current counter list state
  /// [context] provides the entity execution context
  ///
  /// Returns a [CounterAddedToList] event.
  Future<RemoteEvent> add(
    AddCounterToList command,
    CounterListState state,
    EntityContext context,
  ) async {
    return CounterAddedToList(counterId: command.counterId);
  }

  /// Removes a counter reference from the list.
  ///
  /// [command] contains the ID of the counter to remove
  /// [state] current counter list state
  /// [context] provides the entity execution context
  ///
  /// Returns a [CounterRemovedFromList] event.
  Future<RemoteEvent> remove(
    RemoveCounterFromList command,
    CounterListState state,
    EntityContext context,
  ) async {
    return CounterRemovedFromList(counterId: command.counterId);
  }

  @override
  void initHandlers(EntityHandlers<CounterListState> handlers) {
    handlers
      ..addStateFromJson(CounterListState.fromJson)
      ..add<AddCounterToList>(add, AddCounterToList.fromJson)
      ..add<RemoveCounterFromList>(remove, RemoveCounterFromList.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {
    // No migrations needed for this test entity
  }
}
