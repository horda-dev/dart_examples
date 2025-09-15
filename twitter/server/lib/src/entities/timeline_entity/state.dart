import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'messages.dart';

part 'state.g.dart';

/// State of [CommentEntity].
///
/// {@category Entity State}
@JsonSerializable(constructor: '_json')
class TimelineEntityState implements EntityState {
  TimelineEntityState._json();

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      _ => null,
    };
  }

  factory TimelineEntityState.fromJson(Map<String, dynamic> json) {
    return _$TimelineEntityStateFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$TimelineEntityStateToJson(this);
  }
}
