// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientCreateCommentRequested _$ClientCreateCommentRequestedFromJson(
  Map<String, dynamic> json,
) => ClientCreateCommentRequested(
  text: json['text'] as String,
  parentTweetId: json['parentTweetId'] as String,
  parentCommentId: json['parentCommentId'] as String?,
);

Map<String, dynamic> _$ClientCreateCommentRequestedToJson(
  ClientCreateCommentRequested instance,
) => <String, dynamic>{
  'text': instance.text,
  'parentTweetId': instance.parentTweetId,
  'parentCommentId': instance.parentCommentId,
};

ClientCreateTweetRequested _$ClientCreateTweetRequestedFromJson(
  Map<String, dynamic> json,
) => ClientCreateTweetRequested(
  authorUserId: json['authorUserId'] as String,
  text: json['text'] as String,
  attachmentBase64: json['attachmentBase64'] as String?,
  timelineIds: (json['timelineIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ClientCreateTweetRequestedToJson(
  ClientCreateTweetRequested instance,
) => <String, dynamic>{
  'authorUserId': instance.authorUserId,
  'text': instance.text,
  'attachmentBase64': instance.attachmentBase64,
  'timelineIds': instance.timelineIds,
};

ClientRegisterUserRequested _$ClientRegisterUserRequestedFromJson(
  Map<String, dynamic> json,
) => ClientRegisterUserRequested(
  json['handle'] as String,
  json['displayName'] as String,
  json['email'] as String,
  json['avatarBase64'] as String,
);

Map<String, dynamic> _$ClientRegisterUserRequestedToJson(
  ClientRegisterUserRequested instance,
) => <String, dynamic>{
  'handle': instance.handle,
  'displayName': instance.displayName,
  'email': instance.email,
  'avatarBase64': instance.avatarBase64,
};

ClientRetweetRequested _$ClientRetweetRequestedFromJson(
  Map<String, dynamic> json,
) => ClientRetweetRequested(
  json['tweetId'] as String,
  (json['timelineIds'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$ClientRetweetRequestedToJson(
  ClientRetweetRequested instance,
) => <String, dynamic>{
  'tweetId': instance.tweetId,
  'timelineIds': instance.timelineIds,
};

ClientToggleCommentLikeRequested _$ClientToggleCommentLikeRequestedFromJson(
  Map<String, dynamic> json,
) => ClientToggleCommentLikeRequested(json['commentId'] as String);

Map<String, dynamic> _$ClientToggleCommentLikeRequestedToJson(
  ClientToggleCommentLikeRequested instance,
) => <String, dynamic>{'commentId': instance.commentId};

ClientToggleTweetLikeRequested _$ClientToggleTweetLikeRequestedFromJson(
  Map<String, dynamic> json,
) => ClientToggleTweetLikeRequested(json['tweetId'] as String);

Map<String, dynamic> _$ClientToggleTweetLikeRequestedToJson(
  ClientToggleTweetLikeRequested instance,
) => <String, dynamic>{'tweetId': instance.tweetId};

ClientToggleUserBlockRequested _$ClientToggleUserBlockRequestedFromJson(
  Map<String, dynamic> json,
) => ClientToggleUserBlockRequested(json['userId'] as String);

Map<String, dynamic> _$ClientToggleUserBlockRequestedToJson(
  ClientToggleUserBlockRequested instance,
) => <String, dynamic>{'userId': instance.userId};

ClientToggleUserFollowRequested _$ClientToggleUserFollowRequestedFromJson(
  Map<String, dynamic> json,
) => ClientToggleUserFollowRequested(json['followedUserId'] as String);

Map<String, dynamic> _$ClientToggleUserFollowRequestedToJson(
  ClientToggleUserFollowRequested instance,
) => <String, dynamic>{'followedUserId': instance.followedUserId};

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
