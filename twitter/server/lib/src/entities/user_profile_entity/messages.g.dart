// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserProfile _$CreateUserProfileFromJson(Map<String, dynamic> json) =>
    CreateUserProfile(
      json['accountId'] as String,
      json['displayName'] as String,
    );

Map<String, dynamic> _$CreateUserProfileToJson(CreateUserProfile instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'displayName': instance.displayName,
    };

UserProfileCreated _$UserProfileCreatedFromJson(Map<String, dynamic> json) =>
    UserProfileCreated(
      json['accountId'] as String,
      json['displayName'] as String,
    );

Map<String, dynamic> _$UserProfileCreatedToJson(UserProfileCreated instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'displayName': instance.displayName,
    };
