import 'package:horda_server/horda_server.dart';

import 'messages.dart';
import 'state.dart';

class CounterEntity extends Entity<CounterState> {
  Future<CounterCreated> create(
    CreateCounter command,
    EntityContext context,
  ) async {
    return CounterCreated(name: command.name, count: command.initialValue);
  }

  Future<RemoteEvent> delete(
    DeleteCounter command,
    CounterState state,
    EntityContext context,
  ) async {
    context.stop();
    return CounterDeleted();
  }

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

  Future<RemoteEvent> freeze(
    FreezeCounter command,
    CounterState state,
    EntityContext context,
  ) async {
    if (!state.isFrozen) {
      throw CounterEntityException('counter is not frozen');
    }

    return CounterFreezeChanged(newValue: true);
  }

  Future<RemoteEvent> unfreeze(
    UnfreezeCounter command,
    CounterState state,
    EntityContext context,
  ) async {
    if (state.isFrozen) {
      throw CounterEntityException('counter is already frozen');
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

class CounterEntityException implements Exception {
  final String message;

  CounterEntityException(this.message);

  @override
  String toString() {
    return 'CounterEntityException: $message';
  }
}
