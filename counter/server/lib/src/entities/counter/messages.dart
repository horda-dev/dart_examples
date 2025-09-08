import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Command to create a new counter with a given name and initial value.
///
/// This is the initialization command for a counter entity in the Horda platform.
@JsonSerializable()
class CreateCounter extends RemoteCommand {
  /// The display name for the counter.
  final String name;

  /// The starting value for the counter (defaults to 0).
  final int initialValue;

  /// Creates a new counter creation command.
  ///
  /// [name] is required and will be the display name of the counter.
  /// [initialValue] defaults to 0 if not specified.
  CreateCounter({required this.name, this.initialValue = 0});

  factory CreateCounter.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterToJson(this);
}

/// Command to delete an existing counter.
///
/// This command will stop the counter entity and remove it from the system.
@JsonSerializable()
class DeleteCounter extends RemoteCommand {
  /// Creates a new delete counter command.
  DeleteCounter();

  factory DeleteCounter.fromJson(Map<String, dynamic> json) =>
      _$DeleteCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeleteCounterToJson(this);
}

/// Command to increment a counter by a specified amount.
///
/// The counter must not be frozen for this operation to succeed.
@JsonSerializable()
class IncrementCounter extends RemoteCommand {
  /// The amount to increment the counter by (defaults to 1).
  final int amount;

  /// Creates a new increment command.
  ///
  /// [amount] defaults to 1 if not specified.
  IncrementCounter({this.amount = 1});

  factory IncrementCounter.fromJson(Map<String, dynamic> json) =>
      _$IncrementCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IncrementCounterToJson(this);
}

/// Command to decrement a counter by a specified amount.
///
/// The counter must not be frozen for this operation to succeed.
@JsonSerializable()
class DecrementCounter extends RemoteCommand {
  /// The amount to decrement the counter by (defaults to 1).
  final int amount;

  /// Creates a new decrement command.
  ///
  /// [amount] defaults to 1 if not specified.
  DecrementCounter({this.amount = 1});

  factory DecrementCounter.fromJson(Map<String, dynamic> json) =>
      _$DecrementCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DecrementCounterToJson(this);
}

/// Command to freeze a counter, preventing increment and decrement operations.
///
/// A frozen counter cannot be modified until it is unfrozen.
@JsonSerializable()
class FreezeCounter extends RemoteCommand {
  /// Creates a new freeze counter command.
  FreezeCounter();

  factory FreezeCounter.fromJson(Map<String, dynamic> json) =>
      _$FreezeCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FreezeCounterToJson(this);
}

/// Command to unfreeze a counter, allowing increment and decrement operations.
///
/// This restores the counter to its normal operational state.
@JsonSerializable()
class UnfreezeCounter extends RemoteCommand {
  /// Creates a new unfreeze counter command.
  UnfreezeCounter();

  factory UnfreezeCounter.fromJson(Map<String, dynamic> json) =>
      _$UnfreezeCounterFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnfreezeCounterToJson(this);
}

/// Event indicating a counter has been successfully created.
///
/// This event is emitted when a new counter entity is initialized.
@JsonSerializable()
class CounterCreated extends RemoteEvent {
  /// The name of the newly created counter.
  final String name;

  /// The initial count value of the counter.
  final int count;

  /// Creates a new counter created event.
  ///
  /// Both [name] and [count] are required parameters.
  CounterCreated({required this.name, required this.count});

  factory CounterCreated.fromJson(Map<String, dynamic> json) =>
      _$CounterCreatedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterCreatedToJson(this);
}

/// Event indicating a counter has been successfully deleted.
///
/// This event is emitted when a counter entity is removed from the system.
@JsonSerializable()
class CounterDeleted extends RemoteEvent {
  /// Creates a new counter deleted event.
  CounterDeleted();

  factory CounterDeleted.fromJson(Map<String, dynamic> json) =>
      _$CounterDeletedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterDeletedToJson(this);
}

/// Event indicating a counter has been incremented.
///
/// This event is emitted when a counter's value is successfully increased.
@JsonSerializable()
class CounterIncremented extends RemoteEvent {
  /// The amount by which the counter was incremented.
  final int amount;

  /// Creates a new counter incremented event.
  ///
  /// [amount] is required and represents the increment value.
  CounterIncremented({required this.amount});

  factory CounterIncremented.fromJson(Map<String, dynamic> json) =>
      _$CounterIncrementedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterIncrementedToJson(this);
}

/// Event indicating a counter has been decremented.
///
/// This event is emitted when a counter's value is successfully decreased.
@JsonSerializable()
class CounterDecremented extends RemoteEvent {
  /// The amount by which the counter was decremented.
  final int amount;

  /// Creates a new counter decremented event.
  ///
  /// [amount] is required and represents the decrement value.
  CounterDecremented({required this.amount});

  factory CounterDecremented.fromJson(Map<String, dynamic> json) =>
      _$CounterDecrementedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterDecrementedToJson(this);
}

/// Event indicating a counter's freeze status has changed.
///
/// This event is emitted when a counter is frozen or unfrozen.
@JsonSerializable()
class CounterFreezeChanged extends RemoteEvent {
  /// The new freeze status (true for frozen, false for unfrozen).
  final bool newValue;

  /// Creates a new counter freeze changed event.
  ///
  /// [newValue] is required - true indicates frozen, false indicates unfrozen.
  CounterFreezeChanged({required this.newValue});

  factory CounterFreezeChanged.fromJson(Map<String, dynamic> json) =>
      _$CounterFreezeChangedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterFreezeChangedToJson(this);
}
