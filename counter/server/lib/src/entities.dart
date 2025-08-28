import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';
import 'messages.dart';

part 'entities.g.dart';

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

  CounterViewGroup.fromInitEvent(CounterCreatedEvent event)
    : nameView = ValueView(name: 'name', value: event.name),
      valueView = CounterView(name: 'value', value: event.count);

  void incremented(CounterIncrementedEvent event) {
    valueView.increment(event.amount);
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

class CounterEntityException implements Exception {
  final String message;

  CounterEntityException(this.message);

  @override
  String toString() {
    return 'CounterEntityException: $message';
  }
}
