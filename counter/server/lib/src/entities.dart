import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'messages.dart';

part 'entities.g.dart';

//
// CounterListEntity
//

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

@JsonSerializable()
class CounterListState extends EntityState {
  // TODO: remove this state
  final List<String> counterIds;

  CounterListState({List<String>? counterIds}) : counterIds = counterIds ?? [];

  factory CounterListState.fromJson(Map<String, dynamic> json) =>
      _$CounterListStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterListStateToJson(this);

  void counterAdded(CounterAddedToListEvent event) {
    counterIds.add(event.counterId);
  }

  void counterRemoved(CounterRemovedFromListEvent event) {
    counterIds.remove(event.counterId);
  }

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      CounterAddedToListEvent() => counterAdded(event),
      CounterRemovedFromListEvent() => counterRemoved(event),
      _ => null,
    };
  }
}

class CounterListViewGroup extends EntityViewGroup {
  final RefListView countersView = RefListView(name: 'counters');

  void counterAdded(CounterAddedToListEvent event) {
    countersView.addItem(event.counterId);
  }

  void counterRemoved(CounterRemovedFromListEvent event) {
    countersView.removeItem(event.counterId);
  }

  @override
  void initViews(ViewGroup views) {
    views.add(countersView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..add<CounterAddedToListEvent>(counterAdded)
      ..add<CounterRemovedFromListEvent>(counterRemoved);
  }
}

//
// CounterEntity
//

class CounterEntity extends Entity<CounterState> {
  Future<CounterCreatedEvent> create(
    CreateCounterCommand command,
    EntityContext context,
  ) async {
    return CounterCreatedEvent(name: command.name, count: command.initialValue);
  }

  Future<RemoteEvent> delete(
    DeleteCounterCommand command,
    EntityContext context,
  ) async {
    context.stop();
    return CounterDeletedEvent();
  }

  Future<RemoteEvent> increment(
    IncrementCounterCommand command,
    CounterState state,
    EntityContext context,
  ) async {
    if (state.isFrozen) {
      throw CounterEntityException('counter is frozen');
    }

    return CounterIncrementedEvent(amount: command.amount);
  }

  Future<RemoteEvent> decrement(
    DecrementCounterCommand command,
    CounterState state,
    EntityContext context,
  ) async {
    if (state.isFrozen) {
      throw CounterEntityException('counter is frozen');
    }

    return CounterDecrementedEvent(amount: command.amount);
  }

  Future<RemoteEvent> freeze(
    FreezeCounterCommand command,
    CounterState state,
    EntityContext context,
  ) async {
    if (!state.isFrozen) {
      throw CounterEntityException('counter is not frozen');
    }

    return CounterFreezeChangedEvent(newValue: true);
  }

  Future<RemoteEvent> unfreeze(
    UnfreezeCounterCommand command,
    CounterState state,
    EntityContext context,
  ) async {
    if (state.isFrozen) {
      throw CounterEntityException('counter is already frozen');
    }

    return CounterFreezeChangedEvent(newValue: false);
  }

  CounterState _stateInit(CounterCreatedEvent event) {
    return CounterState();
  }

  @override
  void initHandlers(EntityHandlers<CounterState> handlers) {
    handlers
      ..addStateFromJson(CounterState.fromJson)
      ..addInit<CreateCounterCommand, CounterCreatedEvent>(
        create,
        CreateCounterCommand.fromJson,
        _stateInit,
      )
      ..add<IncrementCounterCommand>(
        increment,
        IncrementCounterCommand.fromJson,
      )
      ..add<DecrementCounterCommand>(
        decrement,
        DecrementCounterCommand.fromJson,
      )
      ..add<FreezeCounterCommand>(freeze, FreezeCounterCommand.fromJson)
      ..add<UnfreezeCounterCommand>(unfreeze, UnfreezeCounterCommand.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {
    // No migrations needed for this test entity
  }
}

@JsonSerializable()
class CounterState extends EntityState {
  bool get isFrozen => _isFrozen;

  CounterState({bool isFrozen = false}) : _isFrozen = isFrozen;

  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterStateToJson(this);

  void freezeChanged(CounterFreezeChangedEvent event) {
    _isFrozen = event.newValue;
  }

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      CounterFreezeChangedEvent() => freezeChanged(event),
      _ => null,
    };
  }

  bool _isFrozen;
}

class CounterViewGroup extends EntityViewGroup {
  final ValueView<String> nameView;
  final CounterView valueView;
  final ValueView<String> frozenStateView;

  CounterViewGroup.fromInitEvent(CounterCreatedEvent event)
    : nameView = ValueView(name: 'name', value: event.name),
      valueView = CounterView(name: 'value', value: event.count),
      frozenStateView = ValueView(name: 'isFroze', value: "not frozen");

  void incremented(CounterIncrementedEvent event) {
    valueView.increment(event.amount);
  }

  void decremented(CounterDecrementedEvent event) {
    valueView.decrement(event.amount);
  }

  void freezeChanged(CounterFreezeChangedEvent event) {
    if (event.newValue) {
      frozenStateView.value = "frozen";
    } else {
      frozenStateView.value = "not frozen";
    }
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(nameView)
      ..add(valueView)
      ..add(frozenStateView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<CounterCreatedEvent>(CounterViewGroup.fromInitEvent)
      ..add<CounterIncrementedEvent>(incremented)
      ..add<CounterDecrementedEvent>(decremented)
      ..add<CounterFreezeChangedEvent>(freezeChanged);
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
