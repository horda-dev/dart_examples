import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';

part 'state.g.dart';

@JsonSerializable()
class CounterListState extends EntityState {
  // TODO: remove this state
  final List<String> counterIds;

  CounterListState({List<String>? counterIds}) : counterIds = counterIds ?? [];

  factory CounterListState.fromJson(Map<String, dynamic> json) =>
      _$CounterListStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterListStateToJson(this);

  void counterAdded(CounterAddedToListEvent event) {
    counterIds.add(event.counterId);
  }

  void counterRemoved(CounterRemovedFromListEvent event) {
    counterIds.remove(event.counterId);
  }

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      CounterAddedToListEvent() => counterAdded(event),
      CounterRemovedFromListEvent() => counterRemoved(event),
      _ => null,
    };
  }
}
