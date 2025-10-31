import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'messages.dart';

part 'state.g.dart';

/// State of [ExploreFeedEntity].
///
/// {@category Entity State}
@JsonSerializable(constructor: '_json')
class ExploreFeedEntityState implements EntityState {
  ExploreFeedEntityState._json();

  ExploreFeedEntityState();

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      _ => null,
    };
  }

  factory ExploreFeedEntityState.fromJson(Map<String, dynamic> json) {
    return _$ExploreFeedEntityStateFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$ExploreFeedEntityStateToJson(this);
  }
}
