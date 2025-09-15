import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Creates a user profile with display name.
///
/// {@category Entity Command}
@JsonSerializable()
class CreateUserProfile extends RemoteCommand {
  CreateUserProfile(this.displayName);

  /// User's display name
  String displayName;

  factory CreateUserProfile.fromJson(Map<String, dynamic> json) {
    return _$CreateUserProfileFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateUserProfileToJson(this);
  }
}

/// Event indicating a user profile was successfully created.
///
/// {@category Entity Event}
@JsonSerializable()
class UserProfileCreated extends RemoteEvent {
  UserProfileCreated(this.displayName);

  /// User's display name
  String displayName;

  factory UserProfileCreated.fromJson(Map<String, dynamic> json) {
    return _$UserProfileCreatedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserProfileCreatedToJson(this);
  }
}
