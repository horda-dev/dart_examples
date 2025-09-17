// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadProfilePicture _$UploadProfilePictureFromJson(
  Map<String, dynamic> json,
) => UploadProfilePicture(
  json['userId'] as String,
  json['imageDataBase64'] as String,
);

Map<String, dynamic> _$UploadProfilePictureToJson(
  UploadProfilePicture instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'imageDataBase64': instance.imageDataBase64,
};

ProfilePictureUploaded _$ProfilePictureUploadedFromJson(
  Map<String, dynamic> json,
) => ProfilePictureUploaded(
  json['userId'] as String,
  json['pictureUrl'] as String,
);

Map<String, dynamic> _$ProfilePictureUploadedToJson(
  ProfilePictureUploaded instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'pictureUrl': instance.pictureUrl,
};

ProfilePictureUploadFailed _$ProfilePictureUploadFailedFromJson(
  Map<String, dynamic> json,
) => ProfilePictureUploadFailed(
  json['userId'] as String,
  json['reason'] as String,
);

Map<String, dynamic> _$ProfilePictureUploadFailedToJson(
  ProfilePictureUploadFailed instance,
) => <String, dynamic>{'userId': instance.userId, 'reason': instance.reason};
