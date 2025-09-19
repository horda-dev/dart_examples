// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserProfile _$CreateUserProfileFromJson(Map<String, dynamic> json) =>
    CreateUserProfile(
      json['accountId'] as String,
      json['displayName'] as String,
      json['avatarUrl'] as String,
    );

Map<String, dynamic> _$CreateUserProfileToJson(CreateUserProfile instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
    };

UserProfileCreated _$UserProfileCreatedFromJson(Map<String, dynamic> json) =>
    UserProfileCreated(
      json['accountId'] as String,
      json['displayName'] as String,
      json['avatarUrl'] as String,
    );

Map<String, dynamic> _$UserProfileCreatedToJson(UserProfileCreated instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
    };

UpdateProfilePictureUrl _$UpdateProfilePictureUrlFromJson(
  Map<String, dynamic> json,
) => UpdateProfilePictureUrl(json['avatarUrl'] as String);

Map<String, dynamic> _$UpdateProfilePictureUrlToJson(
  UpdateProfilePictureUrl instance,
) => <String, dynamic>{'avatarUrl': instance.avatarUrl};

ProfilePictureUrlUpdated _$ProfilePictureUrlUpdatedFromJson(
  Map<String, dynamic> json,
) => ProfilePictureUrlUpdated(
  json['newAvatarUrl'] as String,
  json['oldAvatarUrl'] as String,
);

Map<String, dynamic> _$ProfilePictureUrlUpdatedToJson(
  ProfilePictureUrlUpdated instance,
) => <String, dynamic>{
  'newAvatarUrl': instance.newAvatarUrl,
  'oldAvatarUrl': instance.oldAvatarUrl,
};

UpdateUserProfile _$UpdateUserProfileFromJson(Map<String, dynamic> json) =>
    UpdateUserProfile(json['displayName'] as String, json['bio'] as String);

Map<String, dynamic> _$UpdateUserProfileToJson(UpdateUserProfile instance) =>
    <String, dynamic>{'displayName': instance.displayName, 'bio': instance.bio};

UserProfileUpdated _$UserProfileUpdatedFromJson(Map<String, dynamic> json) =>
    UserProfileUpdated(json['displayName'] as String, json['bio'] as String);

Map<String, dynamic> _$UserProfileUpdatedToJson(UserProfileUpdated instance) =>
    <String, dynamic>{'displayName': instance.displayName, 'bio': instance.bio};
