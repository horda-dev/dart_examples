import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

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
