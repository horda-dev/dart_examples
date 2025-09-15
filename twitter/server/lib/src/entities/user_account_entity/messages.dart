import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// {@category Entity Command}
@JsonSerializable()
class CreateUser extends RemoteCommand {
  CreateUser(this.handle, this.email, this.profileId);

  /// User's unique handle
  String handle;

  /// User's email address
  String email;

  /// ID of the related profile entity
  String profileId;

  factory CreateUser.fromJson(Map<String, dynamic> json) {
    return _$CreateUserFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateUserToJson(this);
  }
}

/// {@category Entity Event}
@JsonSerializable()
class UserCreated extends RemoteEvent {
  UserCreated(this.handle, this.email, this.profileId);

  /// User's unique handle
  String handle;

  /// User's email address
  String email;

  /// ID of the related profile entity
  String profileId;

  factory UserCreated.fromJson(Map<String, dynamic> json) {
    return _$UserCreatedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserCreatedToJson(this);
  }
}

/// Command to toggle a follower for the user account.
///
/// {@category Entity Command}
@JsonSerializable()
class ToggleFollower extends RemoteCommand {
  ToggleFollower(this.userId);

  /// ID of the target user to toggle follower status
  String userId;

  factory ToggleFollower.fromJson(Map<String, dynamic> json) {
    return _$ToggleFollowerFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleFollowerToJson(this);
  }
}

/// Event indicating a follower was added.
///
/// {@category Entity Event}
@JsonSerializable()
class FollowerAdded extends RemoteEvent {
  FollowerAdded(this.userId);

  /// ID of the follower added
  String userId;

  factory FollowerAdded.fromJson(Map<String, dynamic> json) {
    return _$FollowerAddedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$FollowerAddedToJson(this);
  }
}

/// Event indicating a follower was removed.
///
/// {@category Entity Event}
@JsonSerializable()
class FollowerRemoved extends RemoteEvent {
  FollowerRemoved(this.userId);

  /// ID of the follower removed
  String userId;

  factory FollowerRemoved.fromJson(Map<String, dynamic> json) {
    return _$FollowerRemovedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$FollowerRemovedToJson(this);
  }
}

/// Command to toggle following status for the user account.
///
/// {@category Entity Command}
@JsonSerializable()
class ToggleFollowing extends RemoteCommand {
  ToggleFollowing(this.userId);

  /// ID of the user to toggle following status
  String userId;

  factory ToggleFollowing.fromJson(Map<String, dynamic> json) {
    return _$ToggleFollowingFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleFollowingToJson(this);
  }
}

/// Event indicating the user started following another user.
///
/// {@category Entity Event}
@JsonSerializable()
class FollowingAdded extends RemoteEvent {
  FollowingAdded(this.userId);

  /// ID of the user followed
  String userId;

  factory FollowingAdded.fromJson(Map<String, dynamic> json) {
    return _$FollowingAddedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$FollowingAddedToJson(this);
  }
}

/// Event indicating the user stopped following another user.
///
/// {@category Entity Event}
@JsonSerializable()
class FollowingRemoved extends RemoteEvent {
  FollowingRemoved(this.userId);

  /// ID of the user unfollowed
  String userId;

  factory FollowingRemoved.fromJson(Map<String, dynamic> json) {
    return _$FollowingRemovedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$FollowingRemovedToJson(this);
  }
}
