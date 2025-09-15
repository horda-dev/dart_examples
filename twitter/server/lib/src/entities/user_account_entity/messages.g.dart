// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUser _$CreateUserFromJson(Map<String, dynamic> json) => CreateUser(
  json['handle'] as String,
  json['email'] as String,
  json['profileId'] as String,
);

Map<String, dynamic> _$CreateUserToJson(CreateUser instance) =>
    <String, dynamic>{
      'handle': instance.handle,
      'email': instance.email,
      'profileId': instance.profileId,
    };

UserCreated _$UserCreatedFromJson(Map<String, dynamic> json) => UserCreated(
  json['handle'] as String,
  json['email'] as String,
  json['profileId'] as String,
);

Map<String, dynamic> _$UserCreatedToJson(UserCreated instance) =>
    <String, dynamic>{
      'handle': instance.handle,
      'email': instance.email,
      'profileId': instance.profileId,
    };

ToggleFollower _$ToggleFollowerFromJson(Map<String, dynamic> json) =>
    ToggleFollower(json['userId'] as String);

Map<String, dynamic> _$ToggleFollowerToJson(ToggleFollower instance) =>
    <String, dynamic>{'userId': instance.userId};

FollowerAdded _$FollowerAddedFromJson(Map<String, dynamic> json) =>
    FollowerAdded(json['userId'] as String);

Map<String, dynamic> _$FollowerAddedToJson(FollowerAdded instance) =>
    <String, dynamic>{'userId': instance.userId};

FollowerRemoved _$FollowerRemovedFromJson(Map<String, dynamic> json) =>
    FollowerRemoved(json['userId'] as String);

Map<String, dynamic> _$FollowerRemovedToJson(FollowerRemoved instance) =>
    <String, dynamic>{'userId': instance.userId};

ToggleFollowing _$ToggleFollowingFromJson(Map<String, dynamic> json) =>
    ToggleFollowing(json['userId'] as String);

Map<String, dynamic> _$ToggleFollowingToJson(ToggleFollowing instance) =>
    <String, dynamic>{'userId': instance.userId};

FollowingAdded _$FollowingAddedFromJson(Map<String, dynamic> json) =>
    FollowingAdded(json['userId'] as String);

Map<String, dynamic> _$FollowingAddedToJson(FollowingAdded instance) =>
    <String, dynamic>{'userId': instance.userId};

FollowingRemoved _$FollowingRemovedFromJson(Map<String, dynamic> json) =>
    FollowingRemoved(json['userId'] as String);

Map<String, dynamic> _$FollowingRemovedToJson(FollowingRemoved instance) =>
    <String, dynamic>{'userId': instance.userId};
