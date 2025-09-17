import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// {@category Entity Command}
@JsonSerializable()
class CreateUserAccount extends RemoteCommand {
  CreateUserAccount(this.handle, this.email, this.profileId, this.timelineId);

  /// User's unique handle
  String handle;

  /// User's email address
  String email;

  /// ID of the related profile entity
  String profileId;

  /// ID of the related timeline entity
  String timelineId;

  factory CreateUserAccount.fromJson(Map<String, dynamic> json) {
    return _$CreateUserAccountFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateUserAccountToJson(this);
  }
}

/// {@category Entity Event}
@JsonSerializable()
class UserAccountCreated extends RemoteEvent {
  UserAccountCreated(this.handle, this.email, this.profileId, this.timelineId);

  /// User's unique handle
  String handle;

  /// User's email address
  String email;

  /// ID of the related profile entity
  String profileId;

  /// ID of the related timeline entity
  String timelineId;

  factory UserAccountCreated.fromJson(Map<String, dynamic> json) {
    return _$UserAccountCreatedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserAccountCreatedToJson(this);
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

/// {@category Entity Command}
@JsonSerializable()
class ToggleUserBlock extends RemoteCommand {
  ToggleUserBlock(this.userId);

  /// ID of the user to toggle block status
  String userId;

  factory ToggleUserBlock.fromJson(Map<String, dynamic> json) {
    return _$ToggleUserBlockFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ToggleUserBlockToJson(this);
  }
}

/// {@category Entity Event}
@JsonSerializable()
class UserBlocked extends RemoteEvent {
  UserBlocked(this.userId);

  /// ID of the user who was blocked
  String userId;

  factory UserBlocked.fromJson(Map<String, dynamic> json) {
    return _$UserBlockedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserBlockedToJson(this);
  }
}

/// {@category Entity Event}
@JsonSerializable()
class UserUnblocked extends RemoteEvent {
  UserUnblocked(this.userId);

  /// ID of the user who was unblocked
  String userId;

  factory UserUnblocked.fromJson(Map<String, dynamic> json) {
    return _$UserUnblockedFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserUnblockedToJson(this);
  }
}
