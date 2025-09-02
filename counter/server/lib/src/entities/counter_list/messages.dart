import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

@JsonSerializable()
class CreateCounterList extends RemoteCommand {
  CreateCounterList();

  factory CreateCounterList.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterListToJson(this);
}

@JsonSerializable()
class CounterListCreated extends RemoteEvent {
  CounterListCreated();

  factory CounterListCreated.fromJson(Map<String, dynamic> json) =>
      _$CounterListCreatedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterListCreatedToJson(this);
}

@JsonSerializable()
class AddCounterToList extends RemoteCommand {
  final String counterId;

  AddCounterToList({required this.counterId});

  factory AddCounterToList.fromJson(Map<String, dynamic> json) =>
      _$AddCounterToListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddCounterToListToJson(this);
}

@JsonSerializable()
class RemoveCounterFromList extends RemoteCommand {
  final String counterId;

  RemoveCounterFromList({required this.counterId});

  factory RemoveCounterFromList.fromJson(Map<String, dynamic> json) =>
      _$RemoveCounterFromListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoveCounterFromListToJson(this);
}

@JsonSerializable()
class CounterAddedToList extends RemoteEvent {
  final String counterId;

  CounterAddedToList({required this.counterId});

  factory CounterAddedToList.fromJson(Map<String, dynamic> json) =>
      _$CounterAddedToListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterAddedToListToJson(this);
}

@JsonSerializable()
class CounterRemovedFromList extends RemoteEvent {
  final String counterId;

  CounterRemovedFromList({required this.counterId});

  factory CounterRemovedFromList.fromJson(Map<String, dynamic> json) =>
      _$CounterRemovedFromListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterRemovedFromListToJson(this);
}