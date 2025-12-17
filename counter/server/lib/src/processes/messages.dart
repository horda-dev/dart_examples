import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Process request messages for counter operations.
///
/// These events are sent to the ClientProcesses to initiate various
/// counter-related workflows. Each request triggers a coordinated
/// sequence of entity and service interactions.

/// {@category Client Event}
/// Request to create the global counter list entity.
///
/// This request should typically be sent once during system initialization
/// to set up the shared counter list that will manage all counters.
@JsonSerializable()
class CreateCounterListRequested extends RemoteEvent {
  /// Creates a new counter list creation request.
  CreateCounterListRequested();

  factory CreateCounterListRequested.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterListRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterListRequestedToJson(this);
}

/// {@category Client Event}
/// Request to create a new counter with validation and list registration.
///
/// This request triggers a multi-step process involving name validation,
/// counter entity creation, and registration in the global counter list.
@JsonSerializable()
class CreateCounterRequested extends RemoteEvent {
  /// The display name for the new counter.
  final String name;

  /// The initial value for the counter.
  final int initialValue;

  /// Creates a new counter creation request.
  ///
  /// [name] is required and will be validated for length
  /// [initialValue] is required and sets the starting counter value
  CreateCounterRequested({required this.name, required this.initialValue});

  factory CreateCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterRequestedToJson(this);
}

/// {@category Client Event}
/// Request to delete a counter and remove it from the global list.
///
/// This request triggers the deletion of the counter entity and its
/// removal from the shared counter list.
@JsonSerializable()
class DeleteCounterRequested extends RemoteEvent {
  /// The unique identifier of the counter to delete.
  final String counterKey;

  /// Creates a new counter deletion request.
  ///
  /// [counterKey] must be the item key of the counter in the list.
  DeleteCounterRequested({required this.counterKey});

  factory DeleteCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$DeleteCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeleteCounterRequestedToJson(this);
}

/// {@category Client Event}
/// Request to increment a counter by a specified amount.
///
/// This request sends an increment command to the target counter entity.
/// The operation will fail if the counter is currently frozen.
@JsonSerializable()
class IncrementCounterRequested extends RemoteEvent {
  /// The unique identifier of the counter to increment.
  final String counterId;

  /// The amount by which to increment the counter.
  final int amount;

  /// Creates a new counter increment request.
  ///
  /// [counterId] must be a valid existing counter entity ID
  /// [amount] is the increment value (can be positive or negative)
  IncrementCounterRequested({required this.counterId, required this.amount});

  factory IncrementCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$IncrementCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IncrementCounterRequestedToJson(this);
}

/// {@category Client Event}
/// Request to decrement a counter by a specified amount.
///
/// This request sends a decrement command to the target counter entity.
/// The operation will fail if the counter is currently frozen.
@JsonSerializable()
class DecrementCounterRequested extends RemoteEvent {
  /// The unique identifier of the counter to decrement.
  final String counterId;

  /// The amount by which to decrement the counter.
  final int amount;

  /// Creates a new counter decrement request.
  ///
  /// [counterId] must be a valid existing counter entity ID
  /// [amount] is the decrement value (should be positive)
  DecrementCounterRequested({required this.counterId, required this.amount});

  factory DecrementCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$DecrementCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DecrementCounterRequestedToJson(this);
}

/// {@category Client Event}
/// Request to freeze a counter to prevent modifications.
///
/// This request sends a freeze command to the target counter entity.
/// A frozen counter cannot be incremented or decremented.
@JsonSerializable()
class FreezeCounterRequested extends RemoteEvent {
  /// The unique identifier of the counter to freeze.
  final String counterId;

  /// Creates a new counter freeze request.
  ///
  /// [counterId] must be a valid existing counter entity ID.
  FreezeCounterRequested({required this.counterId});

  factory FreezeCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$FreezeCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FreezeCounterRequestedToJson(this);
}

/// {@category Client Event}
/// Request to unfreeze a counter to allow modifications.
///
/// This request sends an unfreeze command to the target counter entity.
/// An unfrozen counter can be incremented and decremented normally.
@JsonSerializable()
class UnfreezeCounterRequested extends RemoteEvent {
  /// The unique identifier of the counter to unfreeze.
  final String counterId;

  /// Creates a new counter unfreeze request.
  ///
  /// [counterId] must be a valid existing frozen counter entity ID.
  UnfreezeCounterRequested({required this.counterId});

  factory UnfreezeCounterRequested.fromJson(Map<String, dynamic> json) =>
      _$UnfreezeCounterRequestedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnfreezeCounterRequestedToJson(this);
}
