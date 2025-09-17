import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

import 'entity.dart';
import 'messages.dart';

part 'state.g.dart';

/// State of [UserAccountEntity].
///
/// {@category Entity State}
@JsonSerializable(constructor: '_json')
class UserAccountEntityState implements EntityState {
  UserAccountEntityState._json(this._following, this._followers);

    UserAccountEntityState.fromUserCreated(UserCreated event)
      : _following = [],
        _followers = [];

  /// List of user IDs this user is following
  List<String> get following => _following;

  /// List of user IDs this user is following
  @JsonKey(name: 'following', includeToJson: true, includeFromJson: true)
  List<String> _following;

  /// List of user IDs who follow this user
  List<String> get followers => _followers;

  /// List of user IDs who follow this user
  @JsonKey(name: 'followers', includeToJson: true, includeFromJson: true)
  List<String> _followers;

  void followerAdded(FollowerAdded event) {
    _followers.add(event.userId);
  }

  void followerRemoved(FollowerRemoved event) {
    _followers.remove(event.userId);
  }

  void followingAdded(FollowingAdded event) {
    _following.add(event.userId);
  }

  void followingRemoved(FollowingRemoved event) {
    _following.remove(event.userId);
  }

  @override
  void project(RemoteEvent event) {
    return switch (event) {
      FollowerAdded() => followerAdded(event),
      FollowerRemoved() => followerRemoved(event),
      FollowingAdded() => followingAdded(event),
      FollowingRemoved() => followingRemoved(event),
      _ => null,
    };
  }

  factory UserAccountEntityState.fromJson(Map<String, dynamic> json) {
    return _$UserAccountEntityStateFromJson(json);
  }
  @override
  Map<String, dynamic> toJson() {
    return _$UserAccountEntityStateToJson(this);
  }
}
