import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'messages.dart';

part 'state.g.dart';

/// The persistent state of a counter entity.
/// 
/// This class maintains the counter's freeze status and handles state projections
/// from counter-related events.
@JsonSerializable()
class CounterState extends EntityState {
  /// Whether the counter is currently frozen and cannot be modified.
  bool get isFrozen => _isFrozen;

  /// Creates a new counter state.
  /// 
  /// [isFrozen] defaults to false, meaning the counter starts unfrozen.
  CounterState({bool isFrozen = false}) : _isFrozen = isFrozen;

  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterStateToJson(this);

  /// Updates the freeze status based on a [CounterFreezeChanged] event.
  /// 
  /// [event] contains the new freeze status value.
  void freezeChanged(CounterFreezeChanged event) {
    _isFrozen = event.newValue;
  }

  /// Projects events onto the counter state.
  /// 
  /// This method handles state changes by dispatching events to appropriate
  /// handler methods. Currently only handles [CounterFreezeChanged] events.
  @override
  void project(RemoteEvent event) {
    return switch (event) {
      CounterFreezeChanged() => freezeChanged(event),
      _ => null,
    };
  }

  /// Internal storage for the frozen state.
  bool _isFrozen;
}
