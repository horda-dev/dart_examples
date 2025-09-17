import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'messages.dart';

part 'state.g.dart';

/// State of [UserProfileEntity].
///
/// {@category Entity State}
@JsonSerializable()
class UserProfileEntityState implements EntityState {
  UserProfileEntityState();

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      _ => null,
    };
  }

  factory UserProfileEntityState.fromJson(Map<String, dynamic> json) {
    return _$UserProfileEntityStateFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$UserProfileEntityStateToJson(this);
  }
}
