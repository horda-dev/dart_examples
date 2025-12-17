// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentRequested _$CreateCommentRequestedFromJson(
  Map<String, dynamic> json,
) => CreateCommentRequested(
  text: json['text'] as String,
  parentTweetId: json['parentTweetId'] as String,
  parentCommentId: json['parentCommentId'] as String?,
);

Map<String, dynamic> _$CreateCommentRequestedToJson(
  CreateCommentRequested instance,
) => <String, dynamic>{
  'text': instance.text,
  'parentTweetId': instance.parentTweetId,
  'parentCommentId': instance.parentCommentId,
};

CreateTweetRequested _$CreateTweetRequestedFromJson(
  Map<String, dynamic> json,
) => CreateTweetRequested(
  authorUserId: json['authorUserId'] as String,
  text: json['text'] as String,
  attachmentBase64: json['attachmentBase64'] as String?,
  timelineIds: (json['timelineIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$CreateTweetRequestedToJson(
  CreateTweetRequested instance,
) => <String, dynamic>{
  'authorUserId': instance.authorUserId,
  'text': instance.text,
  'attachmentBase64': instance.attachmentBase64,
  'timelineIds': instance.timelineIds,
};

RegisterUserRequested _$RegisterUserRequestedFromJson(
  Map<String, dynamic> json,
) => RegisterUserRequested(
  json['handle'] as String,
  json['displayName'] as String,
  json['email'] as String,
  json['avatarBase64'] as String,
);

Map<String, dynamic> _$RegisterUserRequestedToJson(
  RegisterUserRequested instance,
) => <String, dynamic>{
  'handle': instance.handle,
  'displayName': instance.displayName,
  'email': instance.email,
  'avatarBase64': instance.avatarBase64,
};

RetweetRequested _$RetweetRequestedFromJson(Map<String, dynamic> json) =>
    RetweetRequested(
      json['tweetId'] as String,
      (json['timelineIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RetweetRequestedToJson(RetweetRequested instance) =>
    <String, dynamic>{
      'tweetId': instance.tweetId,
      'timelineIds': instance.timelineIds,
    };

ToggleCommentLikeRequested _$ToggleCommentLikeRequestedFromJson(
  Map<String, dynamic> json,
) => ToggleCommentLikeRequested(
  json['userKey'] as String?,
  json['commentId'] as String,
);

Map<String, dynamic> _$ToggleCommentLikeRequestedToJson(
  ToggleCommentLikeRequested instance,
) => <String, dynamic>{
  'userKey': instance.userKey,
  'commentId': instance.commentId,
};

ToggleTweetLikeRequested _$ToggleTweetLikeRequestedFromJson(
  Map<String, dynamic> json,
) => ToggleTweetLikeRequested(
  json['userKey'] as String?,
  json['tweetId'] as String,
);

Map<String, dynamic> _$ToggleTweetLikeRequestedToJson(
  ToggleTweetLikeRequested instance,
) => <String, dynamic>{
  'userKey': instance.userKey,
  'tweetId': instance.tweetId,
};

ToggleUserBlockRequested _$ToggleUserBlockRequestedFromJson(
  Map<String, dynamic> json,
) => ToggleUserBlockRequested(
  json['userKey'] as String?,
  json['userId'] as String,
);

Map<String, dynamic> _$ToggleUserBlockRequestedToJson(
  ToggleUserBlockRequested instance,
) => <String, dynamic>{'userKey': instance.userKey, 'userId': instance.userId};

ToggleUserFollowRequested _$ToggleUserFollowRequestedFromJson(
  Map<String, dynamic> json,
) => ToggleUserFollowRequested(
  json['followerUserKey'] as String?,
  json['followingUserKey'] as String?,
  json['followedUserId'] as String,
);

Map<String, dynamic> _$ToggleUserFollowRequestedToJson(
  ToggleUserFollowRequested instance,
) => <String, dynamic>{
  'followerUserKey': instance.followerUserKey,
  'followingUserKey': instance.followingUserKey,
  'followedUserId': instance.followedUserId,
};

UpdateUserProfileRequested _$UpdateUserProfileRequestedFromJson(
  Map<String, dynamic> json,
) => UpdateUserProfileRequested(
  profileId: json['profileId'] as String,
  displayName: json['displayName'] as String,
  bio: json['bio'] as String,
  avatarBase64: json['avatarBase64'] as String?,
);

Map<String, dynamic> _$UpdateUserProfileRequestedToJson(
  UpdateUserProfileRequested instance,
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
