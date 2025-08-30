import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

//
// Process Requests
//

@JsonSerializable()
class CreateCounterListRequested extends RemoteEvent {
  CreateCounterListRequested();

  factory CreateCounterListRequested.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterListRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterListRequestedToJson(this);
}

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
class CounterNameValidated extends RemoteEvent {
  final bool isValid;
  final String invalidReason;

  CounterNameValidated.valid() : isValid = true, invalidReason = '';

  CounterNameValidated.invalid({required this.invalidReason}) : isValid = false;

  CounterNameValidated({required this.isValid, required this.invalidReason});

  factory CounterNameValidated.fromJson(Map<String, dynamic> json) =>
      _$CounterNameValidatedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterNameValidatedToJson(this);
}