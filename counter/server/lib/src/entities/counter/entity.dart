import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'state.dart';

export 'state.dart';
export 'view_group.dart';

part 'entity.g.dart';

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

class CounterEntityException implements Exception {
  final String message;

  CounterEntityException(this.message);

  @override
  String toString() {
    return 'CounterEntityException: $message';
  }
}

//
// Counter entity messages
//

@JsonSerializable()
class CreateCounterCommand extends RemoteCommand {
  final String name;
  final int initialValue;

  CreateCounterCommand({required this.name, this.initialValue = 0});

  factory CreateCounterCommand.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterCommandToJson(this);
}

@JsonSerializable()
class DeleteCounterCommand extends RemoteCommand {
  DeleteCounterCommand();

  factory DeleteCounterCommand.fromJson(Map<String, dynamic> json) =>
      _$DeleteCounterCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeleteCounterCommandToJson(this);
}

@JsonSerializable()
class IncrementCounterCommand extends RemoteCommand {
  final int amount;

  IncrementCounterCommand({this.amount = 1});

  factory IncrementCounterCommand.fromJson(Map<String, dynamic> json) =>
      _$IncrementCounterCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IncrementCounterCommandToJson(this);
}

@JsonSerializable()
class DecrementCounterCommand extends RemoteCommand {
  final int amount;

  DecrementCounterCommand({this.amount = 1});

  factory DecrementCounterCommand.fromJson(Map<String, dynamic> json) =>
      _$DecrementCounterCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DecrementCounterCommandToJson(this);
}

@JsonSerializable()
class FreezeCounterCommand extends RemoteCommand {
  FreezeCounterCommand();

  factory FreezeCounterCommand.fromJson(Map<String, dynamic> json) =>
      _$FreezeCounterCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FreezeCounterCommandToJson(this);
}

@JsonSerializable()
class UnfreezeCounterCommand extends RemoteCommand {
  UnfreezeCounterCommand();

  factory UnfreezeCounterCommand.fromJson(Map<String, dynamic> json) =>
      _$UnfreezeCounterCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnfreezeCounterCommandToJson(this);
}

//
// CounterEntity Events
//

@JsonSerializable()
class CounterCreatedEvent extends RemoteEvent {
  final String name;
  final int count;

  CounterCreatedEvent({required this.name, required this.count});

  factory CounterCreatedEvent.fromJson(Map<String, dynamic> json) =>
      _$CounterCreatedEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterCreatedEventToJson(this);
}

@JsonSerializable()
class CounterDeletedEvent extends RemoteEvent {
  CounterDeletedEvent();

  factory CounterDeletedEvent.fromJson(Map<String, dynamic> json) =>
      _$CounterDeletedEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterDeletedEventToJson(this);
}

@JsonSerializable()
class CounterIncrementedEvent extends RemoteEvent {
  final int amount;

  CounterIncrementedEvent({required this.amount});

  factory CounterIncrementedEvent.fromJson(Map<String, dynamic> json) =>
      _$CounterIncrementedEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterIncrementedEventToJson(this);
}

@JsonSerializable()
class CounterDecrementedEvent extends RemoteEvent {
  final int amount;

  CounterDecrementedEvent({required this.amount});

  factory CounterDecrementedEvent.fromJson(Map<String, dynamic> json) =>
      _$CounterDecrementedEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterDecrementedEventToJson(this);
}

@JsonSerializable()
class CounterFreezeChangedEvent extends RemoteEvent {
  final bool newValue;

  CounterFreezeChangedEvent({required this.newValue});

  factory CounterFreezeChangedEvent.fromJson(Map<String, dynamic> json) =>
      _$CounterFreezeChangedEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterFreezeChangedEventToJson(this);
}