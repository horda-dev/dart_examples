import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';

part 'state.g.dart';

@JsonSerializable()
class CounterState extends EntityState {
  bool get isFrozen => _isFrozen;

  CounterState({bool isFrozen = false}) : _isFrozen = isFrozen;

  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterStateToJson(this);

  void freezeChanged(CounterFreezeChangedEvent event) {
    _isFrozen = event.newValue;
  }

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      CounterFreezeChangedEvent() => freezeChanged(event),
      _ => null,
    };
  }

  bool _isFrozen;
}
