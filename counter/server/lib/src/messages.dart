import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

//
// Process Requests
//

@JsonSerializable()
class CreateCounterRequested extends RemoteEvent {
  final String name;
  final int initialValue;

  CreateCounterRequested({required this.name, required this.initialValue});

  factory CreateCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterRequestedToJson(this);
}

@JsonSerializable()
class DeleteCounterRequested extends RemoteEvent {
  final String counterId;

  DeleteCounterRequested({required this.counterId});

  factory DeleteCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$DeleteCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeleteCounterRequestedToJson(this);
}

@JsonSerializable()
class IncrementCounterRequested extends RemoteEvent {
  final String counterId;
  final int amount;

  IncrementCounterRequested({required this.counterId, required this.amount});

  factory IncrementCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$IncrementCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IncrementCounterRequestedToJson(this);
}

@JsonSerializable()
class DecrementCounterRequested extends RemoteEvent {
  final String counterId;
  final int amount;

  DecrementCounterRequested({required this.counterId, required this.amount});

  factory DecrementCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$DecrementCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DecrementCounterRequestedToJson(this);
}

@JsonSerializable()
class FreezeCounterRequested extends RemoteEvent {
  final String counterId;

  FreezeCounterRequested({required this.counterId});

  factory FreezeCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$FreezeCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FreezeCounterRequestedToJson(this);
}

@JsonSerializable()
class UnfreezeCounterRequested extends RemoteEvent {
  final String counterId;

  UnfreezeCounterRequested({required this.counterId});

  factory UnfreezeCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$UnfreezeCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnfreezeCounterRequestedToJson(this);
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

//
// CounterListEntity messages
//

@JsonSerializable()
class CreateCounterListCommand extends RemoteCommand {
  final String counterId;

  CreateCounterListCommand({required this.counterId});

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

//
// ValidationService messages
//

@JsonSerializable()
class ValidateCounterName extends RemoteCommand {
  final String name;

  ValidateCounterName({required this.name});

  factory ValidateCounterName.fromJson(Map<String, dynamic> json) =>
      _$ValidateCounterNameFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ValidateCounterNameToJson(this);
}

@JsonSerializable()
class CounterNameIsValid extends RemoteEvent {
  CounterNameIsValid();

  factory CounterNameIsValid.fromJson(Map<String, dynamic> json) =>
      _$CounterNameIsValidFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterNameIsValidToJson(this);
}

@JsonSerializable()
class CounterNameIsInvalid extends RemoteEvent {
  final String reason;

  CounterNameIsInvalid({required this.reason});

  factory CounterNameIsInvalid.fromJson(Map<String, dynamic> json) =>
      _$CounterNameIsInvalidFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterNameIsInvalidToJson(this);
}