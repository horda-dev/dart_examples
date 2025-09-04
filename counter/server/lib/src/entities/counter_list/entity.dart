import 'package:horda_server/horda_server.dart';

import 'state.dart';
import 'messages.dart';

class CounterListEntity extends Entity<CounterListState> {
  Future<CounterListCreated> create(
    CreateCounterList command,
    EntityContext context,
  ) async {
    return CounterListCreated();
  }

  Future<RemoteEvent> add(
    AddCounterToList command,
    CounterListState state,
    EntityContext context,
  ) async {
    return CounterAddedToList(counterId: command.counterId);
  }

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
      ..addInit<CreateCounterList, CounterListCreated>(
        create,
        CreateCounterList.fromJson,
        (_) => CounterListState(),
      )
      ..add<AddCounterToList>(add, AddCounterToList.fromJson)
      ..add<RemoveCounterFromList>(remove, RemoveCounterFromList.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {
    // No migrations needed for this test entity
  }
}
