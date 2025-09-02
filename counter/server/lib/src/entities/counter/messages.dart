import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

@JsonSerializable()
class CreateCounter extends RemoteCommand {
  final String name;
  final int initialValue;

  CreateCounter({required this.name, this.initialValue = 0});

  factory CreateCounter.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterToJson(this);
}

@JsonSerializable()
class DeleteCounter extends RemoteCommand {
  DeleteCounter();

  factory DeleteCounter.fromJson(Map<String, dynamic> json) =>
      _$DeleteCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeleteCounterToJson(this);
}

@JsonSerializable()
class IncrementCounter extends RemoteCommand {
  final int amount;

  IncrementCounter({this.amount = 1});

  factory IncrementCounter.fromJson(Map<String, dynamic> json) =>
      _$IncrementCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IncrementCounterToJson(this);
}

@JsonSerializable()
class DecrementCounter extends RemoteCommand {
  final int amount;

  DecrementCounter({this.amount = 1});

  factory DecrementCounter.fromJson(Map<String, dynamic> json) =>
      _$DecrementCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DecrementCounterToJson(this);
}

@JsonSerializable()
class FreezeCounter extends RemoteCommand {
  FreezeCounter();

  factory FreezeCounter.fromJson(Map<String, dynamic> json) =>
      _$FreezeCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FreezeCounterToJson(this);
}

@JsonSerializable()
class UnfreezeCounter extends RemoteCommand {
  UnfreezeCounter();

  factory UnfreezeCounter.fromJson(Map<String, dynamic> json) =>
      _$UnfreezeCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnfreezeCounterToJson(this);
}

@JsonSerializable()
class CounterCreated extends RemoteEvent {
  final String name;
  final int count;

  CounterCreated({required this.name, required this.count});

  factory CounterCreated.fromJson(Map<String, dynamic> json) =>
      _$CounterCreatedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterCreatedToJson(this);
}

@JsonSerializable()
class CounterDeleted extends RemoteEvent {
  CounterDeleted();

  factory CounterDeleted.fromJson(Map<String, dynamic> json) =>
      _$CounterDeletedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterDeletedToJson(this);
}

@JsonSerializable()
class CounterIncremented extends RemoteEvent {
  final int amount;

  CounterIncremented({required this.amount});

  factory CounterIncremented.fromJson(Map<String, dynamic> json) =>
      _$CounterIncrementedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterIncrementedToJson(this);
}

@JsonSerializable()
class CounterDecremented extends RemoteEvent {
  final int amount;

  CounterDecremented({required this.amount});

  factory CounterDecremented.fromJson(Map<String, dynamic> json) =>
      _$CounterDecrementedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterDecrementedToJson(this);
}

@JsonSerializable()
class CounterFreezeChanged extends RemoteEvent {
  final bool newValue;

  CounterFreezeChanged({required this.newValue});

  factory CounterFreezeChanged.fromJson(Map<String, dynamic> json) =>
      _$CounterFreezeChangedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterFreezeChangedToJson(this);
}