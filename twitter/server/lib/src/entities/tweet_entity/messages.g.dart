// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTweet _$CreateTweetFromJson(Map<String, dynamic> json) => CreateTweet(
  json['authorUserId'] as String,
  json['text'] as String,
  json['attachmentUrl'] as String,
);

Map<String, dynamic> _$CreateTweetToJson(CreateTweet instance) =>
    <String, dynamic>{
      'authorUserId': instance.authorUserId,
      'text': instance.text,
      'attachmentUrl': instance.attachmentUrl,
    };

TweetCreated _$TweetCreatedFromJson(Map<String, dynamic> json) => TweetCreated(
  json['authorUserId'] as String,
  json['text'] as String,
  json['attachmentUrl'] as String,
);

Map<String, dynamic> _$TweetCreatedToJson(TweetCreated instance) =>
    <String, dynamic>{
      'authorUserId': instance.authorUserId,
      'text': instance.text,
      'attachmentUrl': instance.attachmentUrl,
    };

ToggleTweetLike _$ToggleTweetLikeFromJson(Map<String, dynamic> json) =>
    ToggleTweetLike(json['userId'] as String);

Map<String, dynamic> _$ToggleTweetLikeToJson(ToggleTweetLike instance) =>
    <String, dynamic>{'userId': instance.userId};

TweetLiked _$TweetLikedFromJson(Map<String, dynamic> json) =>
    TweetLiked(json['userId'] as String);

Map<String, dynamic> _$TweetLikedToJson(TweetLiked instance) =>
    <String, dynamic>{'userId': instance.userId};

TweetUnliked _$TweetUnlikedFromJson(Map<String, dynamic> json) =>
    TweetUnliked(json['userId'] as String);

Map<String, dynamic> _$TweetUnlikedToJson(TweetUnliked instance) =>
    <String, dynamic>{'userId': instance.userId};

RetweetTweet _$RetweetTweetFromJson(Map<String, dynamic> json) =>
    RetweetTweet(json['userId'] as String);

Map<String, dynamic> _$RetweetTweetToJson(RetweetTweet instance) =>
    <String, dynamic>{'userId': instance.userId};

TweetRetweeted _$TweetRetweetedFromJson(Map<String, dynamic> json) =>
    TweetRetweeted(json['userId'] as String);

Map<String, dynamic> _$TweetRetweetedToJson(TweetRetweeted instance) =>
    <String, dynamic>{'userId': instance.userId};

AddTweetComment _$AddTweetCommentFromJson(Map<String, dynamic> json) =>
    AddTweetComment(json['commentId'] as String);

Map<String, dynamic> _$AddTweetCommentToJson(AddTweetComment instance) =>
    <String, dynamic>{'commentId': instance.commentId};

TweetCommentAdded _$TweetCommentAddedFromJson(Map<String, dynamic> json) =>
    TweetCommentAdded(json['commentId'] as String);

Map<String, dynamic> _$TweetCommentAddedToJson(TweetCommentAdded instance) =>
    <String, dynamic>{'commentId': instance.commentId};
