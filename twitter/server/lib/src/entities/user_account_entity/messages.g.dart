// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserAccount _$CreateUserAccountFromJson(Map<String, dynamic> json) =>
    CreateUserAccount(
      json['handle'] as String,
      json['email'] as String,
      json['profileId'] as String,
      json['timelineId'] as String,
    );

Map<String, dynamic> _$CreateUserAccountToJson(CreateUserAccount instance) =>
    <String, dynamic>{
      'handle': instance.handle,
      'email': instance.email,
      'profileId': instance.profileId,
      'timelineId': instance.timelineId,
    };

UserAccountCreated _$UserAccountCreatedFromJson(Map<String, dynamic> json) =>
    UserAccountCreated(
      json['handle'] as String,
      json['email'] as String,
      json['profileId'] as String,
      json['timelineId'] as String,
    );

Map<String, dynamic> _$UserAccountCreatedToJson(UserAccountCreated instance) =>
    <String, dynamic>{
      'handle': instance.handle,
      'email': instance.email,
      'profileId': instance.profileId,
      'timelineId': instance.timelineId,
    };

ToggleFollower _$ToggleFollowerFromJson(Map<String, dynamic> json) =>
    ToggleFollower(json['userKey'] as String?, json['userId'] as String);

Map<String, dynamic> _$ToggleFollowerToJson(ToggleFollower instance) =>
    <String, dynamic>{'userKey': instance.userKey, 'userId': instance.userId};

FollowerAdded _$FollowerAddedFromJson(Map<String, dynamic> json) =>
    FollowerAdded(json['userId'] as String);

Map<String, dynamic> _$FollowerAddedToJson(FollowerAdded instance) =>
    <String, dynamic>{'userId': instance.userId};

FollowerRemoved _$FollowerRemovedFromJson(Map<String, dynamic> json) =>
    FollowerRemoved(json['userKey'] as String, json['userId'] as String);

Map<String, dynamic> _$FollowerRemovedToJson(FollowerRemoved instance) =>
    <String, dynamic>{'userKey': instance.userKey, 'userId': instance.userId};

ToggleFollowing _$ToggleFollowingFromJson(Map<String, dynamic> json) =>
    ToggleFollowing(json['userKey'] as String?, json['userId'] as String);

Map<String, dynamic> _$ToggleFollowingToJson(ToggleFollowing instance) =>
    <String, dynamic>{'userKey': instance.userKey, 'userId': instance.userId};

FollowingAdded _$FollowingAddedFromJson(Map<String, dynamic> json) =>
    FollowingAdded(json['userId'] as String);

Map<String, dynamic> _$FollowingAddedToJson(FollowingAdded instance) =>
    <String, dynamic>{'userId': instance.userId};

FollowingRemoved _$FollowingRemovedFromJson(Map<String, dynamic> json) =>
    FollowingRemoved(json['userKey'] as String, json['userId'] as String);

Map<String, dynamic> _$FollowingRemovedToJson(FollowingRemoved instance) =>
    <String, dynamic>{'userKey': instance.userKey, 'userId': instance.userId};

ToggleUserBlock _$ToggleUserBlockFromJson(Map<String, dynamic> json) =>
    ToggleUserBlock(json['userKey'] as String?, json['userId'] as String);

Map<String, dynamic> _$ToggleUserBlockToJson(ToggleUserBlock instance) =>
    <String, dynamic>{'userKey': instance.userKey, 'userId': instance.userId};

UserBlocked _$UserBlockedFromJson(Map<String, dynamic> json) =>
    UserBlocked(json['userId'] as String);

Map<String, dynamic> _$UserBlockedToJson(UserBlocked instance) =>
    <String, dynamic>{'userId': instance.userId};

UserUnblocked _$UserUnblockedFromJson(Map<String, dynamic> json) =>
    UserUnblocked(json['userKey'] as String, json['userId'] as String);

Map<String, dynamic> _$UserUnblockedToJson(UserUnblocked instance) =>
    <String, dynamic>{'userKey': instance.userKey, 'userId': instance.userId};
