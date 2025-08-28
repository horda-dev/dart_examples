import 'package:horda_server/horda_server.dart';

import 'messages.dart';

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
    final newValue = state.value + command.amount;

    return CounterIncrementedEvent(newValue: newValue);
  }

  Future<RemoteEvent> decrement(
    DecrementCounterCommand command,
    CounterState state,
    EntityContext context,
  ) async {
    final newValue = state.value + command.amount;

    return CounterDecrementedEvent(newValue: newValue);
  }

  Future<RemoteEvent> freeze(
    FreezeCounterCommand command,
    CounterState state,
    EntityContext context,
  ) async {
    return CounterFreezeChangedEvent(newValue: true);
  }

  Future<RemoteEvent> unfreeze(
    UnfreezeCounterCommand command,
    CounterState state,
    EntityContext context,
  ) async {
    return CounterFreezeChangedEvent(newValue: false);
  }

  CounterState _stateInit(CounterCreatedEvent event) {
    return CounterState(value: event.count);
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

class CounterState extends EntityState {
  int get value => _value;

  CounterState({required int value}) : _value = value;

  factory CounterState.fromJson(Map<String, dynamic> json) {
    return CounterState(value: json['value'] as int);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'value': value};
  }

  void incremented(CounterIncrementedEvent event) {
    _value += event.newValue;
  }

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      CounterIncrementedEvent() => incremented(event),
      _ => null,
    };
  }

  int _value;
}

class CounterViewGroup extends EntityViewGroup {
  final ValueView<String> nameView;
  final CounterView valueView;

  CounterViewGroup.fromInitEvent(CounterCreatedEvent event)
    : nameView = ValueView(name: 'name', value: event.name),
      valueView = CounterView(name: 'value', value: event.count);

  void incremented(CounterIncrementedEvent event) {
    valueView.increment(event.newValue);
  }

  @override
  void initViews(ViewGroup views) {
    views
      ..add(nameView)
      ..add(valueView);
  }

  @override
  void initProjectors(EntityViewGroupProjectors projectors) {
    projectors
      ..addInit<CounterCreatedEvent>(CounterViewGroup.fromInitEvent)
      ..add<CounterIncrementedEvent>(incremented);
  }
}
