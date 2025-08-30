import 'package:horda_server/horda_server.dart';

import 'state.dart';
import 'messages.dart';

class CounterListEntity extends Entity<CounterListState> {
  Future<CounterListCreatedEvent> create(
    CreateCounterListCommand command,
    EntityContext context,
  ) async {
    return CounterListCreatedEvent();
  }

  Future<RemoteEvent> add(
    AddCounterToListCommand command,
    CounterListState state,
    EntityContext context,
  ) async {
    if (state.counterIds.contains(command.counterId)) {
      throw Exception('Counter already in list');
    }
    return CounterAddedToListEvent(counterId: command.counterId);
  }

  Future<RemoteEvent> remove(
    RemoveCounterFromListCommand command,
    CounterListState state,
    EntityContext context,
  ) async {
    if (!state.counterIds.contains(command.counterId)) {
      throw Exception('Counter not in list');
    }
    return CounterRemovedFromListEvent(counterId: command.counterId);
  }

  CounterListState _stateInit(CounterListCreatedEvent event) {
    return CounterListState();
  }

  @override
  void initHandlers(EntityHandlers<CounterListState> handlers) {
    handlers
      ..addStateFromJson(CounterListState.fromJson)
      ..addInit<CreateCounterListCommand, CounterListCreatedEvent>(
        create,
        CreateCounterListCommand.fromJson,
        _stateInit,
      )
      ..add<AddCounterToListCommand>(add, AddCounterToListCommand.fromJson)
      ..add<RemoveCounterFromListCommand>(
        remove,
        RemoveCounterFromListCommand.fromJson,
      );
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {
    // No migrations needed for this test entity
  }
}
