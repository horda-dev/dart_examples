import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

/// The persistent state of a counter list entity.
/// 
/// This class maintains the state for a list of counter references.
/// Currently, it serves as a minimal state implementation without
/// additional data beyond the base EntityState.
@JsonSerializable()
class CounterListState extends EntityState {
  /// Creates a new counter list state.
  CounterListState();

  factory CounterListState.fromJson(Map<String, dynamic> json) =>
      _$CounterListStateFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CounterListStateToJson(this);

  /// Projects events onto the counter list state.
  /// 
  /// Currently, this implementation doesn't handle any specific events
  /// as the list management is handled at the view layer.
  @override
  void project(RemoteEvent event) {}
}
