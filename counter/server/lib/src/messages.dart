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
