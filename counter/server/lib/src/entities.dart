import 'package:horda_server/horda_server.dart';

class CreateCounterCommand extends RemoteCommand {
  final String name;
  final int initialCount;

  CreateCounterCommand({required this.name, this.initialCount = 0});

  factory CreateCounterCommand.fromJson(Map<String, dynamic> json) {
    return CreateCounterCommand(
      name: json['name'] as String,
      initialCount: json['initialCount'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'initialCount': initialCount};
  }
}

class IncrementCommand extends RemoteCommand {
  final int amount;

  IncrementCommand({this.amount = 1});

  factory IncrementCommand.fromJson(Map<String, dynamic> json) {
    return IncrementCommand(amount: json['amount'] as int? ?? 1);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'amount': amount};
  }
}

class CounterCreatedEvent extends RemoteEvent {
  final String name;
  final int count;

  CounterCreatedEvent({required this.name, required this.count});

  factory CounterCreatedEvent.fromJson(Map<String, dynamic> json) {
    return CounterCreatedEvent(
      name: json['name'] as String,
      count: json['count'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'count': count};
  }
}

class CounterIncrementedEvent extends RemoteEvent {
  final int newCount;
  final int amount;

  CounterIncrementedEvent({required this.newCount, required this.amount});

  factory CounterIncrementedEvent.fromJson(Map<String, dynamic> json) {
    return CounterIncrementedEvent(
      newCount: json['newCount'] as int,
      amount: json['amount'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'newCount': newCount, 'amount': amount};
  }
}

class CounterEntity extends Entity<CounterState> {
  Future<CounterCreatedEvent> handleInit(
    CreateCounterCommand command,
    EntityContext context,
  ) async {
    return CounterCreatedEvent(name: command.name, count: command.initialCount);
  }

  Future<RemoteEvent> handleIncrement(
    IncrementCommand command,
    CounterState state,
    EntityContext context,
  ) async {
    final newCount = state.value + command.amount;

    return CounterIncrementedEvent(newCount: newCount, amount: command.amount);
  }

  CounterState _stateInit(CounterCreatedEvent event) {
    return CounterState(value: event.count);
  }

  @override
  void initHandlers(EntityHandlers<CounterState> handlers) {
    handlers
      ..addStateFromJson(CounterState.fromJson)
      ..addInit<CreateCounterCommand, CounterCreatedEvent>(
        handleInit,
        CreateCounterCommand.fromJson,
        _stateInit,
      )
      ..add<IncrementCommand>(handleIncrement, IncrementCommand.fromJson);
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
    _value += event.amount;
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
