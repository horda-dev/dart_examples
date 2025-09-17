import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Creates a user profile with display name.
///
/// {@category Entity Command}
@JsonSerializable()
class CreateUserProfile extends RemoteCommand {
  CreateUserProfile(this.accountId, this.displayName, this.avatarUrl);

  /// Account ID to which the profile is tied to
  String accountId;

  /// User's display name
  String displayName;

  /// URL to user's profile picture
  String avatarUrl;

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
  UserProfileCreated(this.accountId, this.displayName, this.avatarUrl);

  /// Account ID to which the profile is tied to
  String accountId;

  /// User's display name
  String displayName;

  /// URL to user's profile picture
  String avatarUrl;

  factory UserProfileCreated.fromJson(Map<String, dynamic> json) {
    return _$UserProfileCreatedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserProfileCreatedToJson(this);
  }
}

/// Updates the user's profile picture URL.
///
/// {@category Entity Command}
@JsonSerializable()
class UpdateProfilePictureUrl extends RemoteCommand {
  UpdateProfilePictureUrl(this.avatarUrl);

  /// New URL for the user's profile picture
  final String avatarUrl;

  factory UpdateProfilePictureUrl.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfilePictureUrlFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateProfilePictureUrlToJson(this);
}

/// Event indicating the user's profile picture URL was updated.
///
/// {@category Entity Event}
@JsonSerializable()
class ProfilePictureUrlUpdated extends RemoteEvent {
  ProfilePictureUrlUpdated(this.newAvatarUrl, this.oldAvatarUrl);

  /// New URL for the user's profile picture
  final String newAvatarUrl;

  /// Old URL to clean up the previous profile picture
  final String oldAvatarUrl;

  factory ProfilePictureUrlUpdated.fromJson(Map<String, dynamic> json) =>
      _$ProfilePictureUrlUpdatedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfilePictureUrlUpdatedToJson(this);
}
