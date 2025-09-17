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
