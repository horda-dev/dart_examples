import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'state.dart';

export 'state.dart';
export 'view_group.dart';

part 'entity.g.dart';

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

//
// CounterListEntity messages
//

@JsonSerializable()
class CreateCounterListCommand extends RemoteCommand {
  CreateCounterListCommand();

  factory CreateCounterListCommand.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterListCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterListCommandToJson(this);
}

@JsonSerializable()
class CounterListCreatedEvent extends RemoteEvent {
  CounterListCreatedEvent();

  factory CounterListCreatedEvent.fromJson(Map<String, dynamic> json) =>
      _$CounterListCreatedEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterListCreatedEventToJson(this);
}

@JsonSerializable()
class AddCounterToListCommand extends RemoteCommand {
  final String counterId;

  AddCounterToListCommand({required this.counterId});

  factory AddCounterToListCommand.fromJson(Map<String, dynamic> json) =>
      _$AddCounterToListCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddCounterToListCommandToJson(this);
}

@JsonSerializable()
class RemoveCounterFromListCommand extends RemoteCommand {
  final String counterId;

  RemoveCounterFromListCommand({required this.counterId});

  factory RemoveCounterFromListCommand.fromJson(Map<String, dynamic> json) =>
      _$RemoveCounterFromListCommandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoveCounterFromListCommandToJson(this);
}

@JsonSerializable()
class CounterAddedToListEvent extends RemoteEvent {
  final String counterId;

  CounterAddedToListEvent({required this.counterId});

  factory CounterAddedToListEvent.fromJson(Map<String, dynamic> json) =>
      _$CounterAddedToListEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterAddedToListEventToJson(this);
}

@JsonSerializable()
class CounterRemovedFromListEvent extends RemoteEvent {
  final String counterId;

  CounterRemovedFromListEvent({required this.counterId});

  factory CounterRemovedFromListEvent.fromJson(Map<String, dynamic> json) =>
      _$CounterRemovedFromListEventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterRemovedFromListEventToJson(this);
}