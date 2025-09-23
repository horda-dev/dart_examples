import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Command to create a new counter list.
///
/// This initializes an empty list that can hold references to counter entities.
///
/// {@category Entity Command}
@JsonSerializable()
class CreateCounterList extends RemoteCommand {
  /// Creates a new counter list creation command.
  CreateCounterList();

  factory CreateCounterList.fromJson(Map<String, dynamic> json) =>
      _$CreateCounterListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateCounterListToJson(this);
}

/// Event indicating a counter list has been successfully created.
///
/// This event is emitted when a new counter list entity is initialized.
///
/// {@category Entity Event}
@JsonSerializable()
class CounterListCreated extends RemoteEvent {
  /// Creates a new counter list created event.
  CounterListCreated();

  factory CounterListCreated.fromJson(Map<String, dynamic> json) =>
      _$CounterListCreatedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterListCreatedToJson(this);
}

/// Command to add a counter reference to the list.
///
/// This adds a reference to an existing counter entity to the managed list.
///
/// {@category Entity Command}
@JsonSerializable()
class AddCounterToList extends RemoteCommand {
  /// The unique identifier of the counter to add to the list.
  final String counterId;

  /// Creates a new add counter to list command.
  ///
  /// [counterId] is required and must be a valid counter entity ID.
  AddCounterToList({required this.counterId});

  factory AddCounterToList.fromJson(Map<String, dynamic> json) =>
      _$AddCounterToListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddCounterToListToJson(this);
}

/// Command to remove a counter reference from the list.
///
/// This removes a reference to a counter entity from the managed list.
///
/// {@category Entity Command}
@JsonSerializable()
class RemoveCounterFromList extends RemoteCommand {
  /// The unique identifier of the counter to remove from the list.
  final String counterId;

  /// Creates a new remove counter from list command.
  ///
  /// [counterId] is required and should exist in the current list.
  RemoveCounterFromList({required this.counterId});

  factory RemoveCounterFromList.fromJson(Map<String, dynamic> json) =>
      _$RemoveCounterFromListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RemoveCounterFromListToJson(this);
}

/// Event indicating a counter reference has been added to the list.
///
/// This event is emitted when a counter reference is successfully added.
///
/// {@category Entity Event}
@JsonSerializable()
class CounterAddedToList extends RemoteEvent {
  /// The unique identifier of the counter that was added.
  final String counterId;

  /// Creates a new counter added to list event.
  ///
  /// [counterId] is required and identifies the added counter.
  CounterAddedToList({required this.counterId});

  factory CounterAddedToList.fromJson(Map<String, dynamic> json) =>
      _$CounterAddedToListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterAddedToListToJson(this);
}

/// Event indicating a counter reference has been removed from the list.
///
/// This event is emitted when a counter reference is successfully removed.
///
/// {@category Entity Event}
@JsonSerializable()
class CounterRemovedFromList extends RemoteEvent {
  /// The unique identifier of the counter that was removed.
  final String counterId;

  /// Creates a new counter removed from list event.
  ///
  /// [counterId] is required and identifies the removed counter.
  CounterRemovedFromList({required this.counterId});

  factory CounterRemovedFromList.fromJson(Map<String, dynamic> json) =>
      _$CounterRemovedFromListFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterRemovedFromListToJson(this);
}
