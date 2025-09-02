import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class CounterListState extends EntityState {
  CounterListState();

  factory CounterListState.fromJson(Map<String, dynamic> json) =>
      _$CounterListStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterListStateToJson(this);

  @override
  void project(RemoteEvent event) {}
}
