import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'messages.dart';

part 'state.g.dart';

/// State of [UserProfileEntity].
///
/// {@category Entity State}
@JsonSerializable(constructor: '_json')
class UserProfileEntityState implements EntityState {
  UserProfileEntityState._json(
    this.avatarUrl,
  );

  UserProfileEntityState.fromUserProfileCreated(UserProfileCreated event)
    : avatarUrl = event.avatarUrl;

  String avatarUrl;

  void profilePictureUrlUpdated(ProfilePictureUrlUpdated event) {
    avatarUrl = event.newAvatarUrl;
  }

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      ProfilePictureUrlUpdated() => profilePictureUrlUpdated(event),
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
