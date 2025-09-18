// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_requested_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientUpdateUserProfileRequested _$ClientUpdateUserProfileRequestedFromJson(
  Map<String, dynamic> json,
) => ClientUpdateUserProfileRequested(
  profileId: json['profileId'] as String,
  displayName: json['displayName'] as String,
  bio: json['bio'] as String,
  avatarBase64: json['avatarBase64'] as String?,
);

Map<String, dynamic> _$ClientUpdateUserProfileRequestedToJson(
  ClientUpdateUserProfileRequested instance,
) => <String, dynamic>{
  'profileId': instance.profileId,
  'displayName': instance.displayName,
  'bio': instance.bio,
  'avatarBase64': instance.avatarBase64,
};
