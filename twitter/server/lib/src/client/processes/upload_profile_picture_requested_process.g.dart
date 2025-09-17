// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_profile_picture_requested_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientUploadProfilePictureRequested
_$ClientUploadProfilePictureRequestedFromJson(Map<String, dynamic> json) =>
    ClientUploadProfilePictureRequested(
      json['profileId'] as String,
      json['imageDataBase64'] as String,
    );

Map<String, dynamic> _$ClientUploadProfilePictureRequestedToJson(
  ClientUploadProfilePictureRequested instance,
) => <String, dynamic>{
  'profileId': instance.profileId,
  'imageDataBase64': instance.imageDataBase64,
};
