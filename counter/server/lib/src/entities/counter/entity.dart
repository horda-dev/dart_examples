import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

/// A Horda entity representing a simple counter with freeze/unfreeze functionality.
///
/// This entity demonstrates basic CRUD operations and state management within the Horda
/// serverless platform. It maintains a counter value that can be incremented, decremented,
/// and toggled between frozen and unfrozen states.
///
/// {@category Entity}
class CounterEntity extends Entity<CounterState> {
  /// Creates a new counter with the specified name and initial value.
  ///
  /// [command] contains the counter name and optional initial value (defaults to 0)
  /// [context] provides the entity execution context
  ///
  /// Returns a [CounterCreated] event with the counter's initial state.
  Future<CounterCreated> create(
    CreateCounter command,
    EntityContext context,
  ) async {
    return CounterCreated(name: command.name, count: command.initialValue);
  }

  /// Deletes the counter and stops the entity.
  ///
  /// [command] the delete command
  /// [state] current counter state
  /// [context] provides the entity execution context
  ///
  /// Returns a [CounterDeleted] event and stops the entity.
  Future<RemoteEvent> delete(
    DeleteCounter command,
    CounterState state,
    EntityContext context,
  ) async {
    context.stop();
    return CounterDeleted();
  }

  /// Increments the counter by the specified amount.
  ///
  /// [command] contains the amount to increment (defaults to 1)
  /// [state] current counter state
  /// [context] provides the entity execution context
  ///
  /// Returns a [CounterIncremented] event.
  /// Throws [CounterEntityException] if the counter is frozen.
  Future<RemoteEvent> increment(
    IncrementCounter command,
    CounterState state,
    EntityContext context,
  ) async {
    if (state.isFrozen) {
      throw CounterEntityException('counter is frozen');
    }

    return CounterIncremented(amount: command.amount);
  }

  /// Decrements the counter by the specified amount.
  ///
  /// [command] contains the amount to decrement (defaults to 1)
  /// [state] current counter state
  /// [context] provides the entity execution context
  ///
  /// Returns a [CounterDecremented] event.
  /// Throws [CounterEntityException] if the counter is frozen.
  Future<RemoteEvent> decrement(
    DecrementCounter command,
    CounterState state,
    EntityContext context,
  ) async {
    if (state.isFrozen) {
      throw CounterEntityException('counter is frozen');
    }

    return CounterDecremented(amount: command.amount);
  }

  /// Freezes the counter, preventing increment and decrement operations.
  ///
  /// [command] the freeze command
  /// [state] current counter state
  /// [context] provides the entity execution context
  ///
  /// Returns a [CounterFreezeChanged] event with newValue set to true.
  /// Throws [CounterEntityException] if the counter is already frozen.
  Future<RemoteEvent> freeze(
    FreezeCounter command,
    CounterState state,
    EntityContext context,
  ) async {
    if (state.isFrozen) {
      throw CounterEntityException('counter is already frozen');
    }

    return CounterFreezeChanged(newValue: true);
  }

  /// Unfreezes the counter, allowing increment and decrement operations.
  ///
  /// [command] the unfreeze command
  /// [state] current counter state
  /// [context] provides the entity execution context
  ///
  /// Returns a [CounterFreezeChanged] event with newValue set to false.
  /// Throws [CounterEntityException] if the counter is not frozen.
  Future<RemoteEvent> unfreeze(
    UnfreezeCounter command,
    CounterState state,
    EntityContext context,
  ) async {
    if (!state.isFrozen) {
      throw CounterEntityException('counter is not frozen');
    }

    return CounterFreezeChanged(newValue: false);
  }

  CounterState _stateInit(CounterCreated event) {
    return CounterState();
  }

  @override
  void initHandlers(EntityHandlers<CounterState> handlers) {
    handlers
      ..addStateFromJson(CounterState.fromJson)
      ..addInit<CreateCounter, CounterCreated>(
        create,
        CreateCounter.fromJson,
        _stateInit,
      )
      ..add<IncrementCounter>(increment, IncrementCounter.fromJson)
      ..add<DecrementCounter>(decrement, DecrementCounter.fromJson)
      ..add<FreezeCounter>(freeze, FreezeCounter.fromJson)
      ..add<UnfreezeCounter>(unfreeze, UnfreezeCounter.fromJson)
      ..add<DeleteCounter>(delete, DeleteCounter.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {
    // No migrations needed for this test entity
  }
}

/// Exception thrown when counter operations violate business rules.
///
/// This exception is thrown when attempting to perform operations on a counter
/// that is in an invalid state (e.g., incrementing a frozen counter).
class CounterEntityException implements Exception {
  /// The error message describing what went wrong.
  final String message;

  /// Creates a new counter entity exception with the given [message].
  CounterEntityException(this.message);

  @override
  String toString() {
    return 'CounterEntityException: $message';
  }
}
