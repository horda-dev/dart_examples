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

RemoveProfilePicture _$RemoveProfilePictureFromJson(
  Map<String, dynamic> json,
) => RemoveProfilePicture(json['pictureUrl'] as String);

Map<String, dynamic> _$RemoveProfilePictureToJson(
  RemoveProfilePicture instance,
) => <String, dynamic>{'pictureUrl': instance.pictureUrl};

ProfilePictureRemoved _$ProfilePictureRemovedFromJson(
  Map<String, dynamic> json,
) => ProfilePictureRemoved(json['pictureUrl'] as String);

Map<String, dynamic> _$ProfilePictureRemovedToJson(
  ProfilePictureRemoved instance,
) => <String, dynamic>{'pictureUrl': instance.pictureUrl};

UploadTweetAttachment _$UploadTweetAttachmentFromJson(
  Map<String, dynamic> json,
) => UploadTweetAttachment(
  json['tweetId'] as String,
  json['imageDataBase64'] as String,
);

Map<String, dynamic> _$UploadTweetAttachmentToJson(
  UploadTweetAttachment instance,
) => <String, dynamic>{
  'tweetId': instance.tweetId,
  'imageDataBase64': instance.imageDataBase64,
};

TweetAttachmentUploaded _$TweetAttachmentUploadedFromJson(
  Map<String, dynamic> json,
) => TweetAttachmentUploaded(
  json['tweetId'] as String,
  json['attachmentUrl'] as String,
);

Map<String, dynamic> _$TweetAttachmentUploadedToJson(
  TweetAttachmentUploaded instance,
) => <String, dynamic>{
  'tweetId': instance.tweetId,
  'attachmentUrl': instance.attachmentUrl,
};

TweetAttachmentUploadFailed _$TweetAttachmentUploadFailedFromJson(
  Map<String, dynamic> json,
) => TweetAttachmentUploadFailed(
  json['tweetId'] as String,
  json['reason'] as String,
);

Map<String, dynamic> _$TweetAttachmentUploadFailedToJson(
  TweetAttachmentUploadFailed instance,
) => <String, dynamic>{'tweetId': instance.tweetId, 'reason': instance.reason};
