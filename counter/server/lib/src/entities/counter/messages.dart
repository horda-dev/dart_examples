import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

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