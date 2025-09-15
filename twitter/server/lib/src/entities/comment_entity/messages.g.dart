// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateComment _$CreateCommentFromJson(Map<String, dynamic> json) =>
    CreateComment(
      json['authorUserId'] as String,
      json['text'] as String,
      json['parentTweetId'] as String,
      json['parentCommentId'] as String,
    );

Map<String, dynamic> _$CreateCommentToJson(CreateComment instance) =>
    <String, dynamic>{
      'authorUserId': instance.authorUserId,
      'text': instance.text,
      'parentTweetId': instance.parentTweetId,
      'parentCommentId': instance.parentCommentId,
    };

CommentCreated _$CommentCreatedFromJson(Map<String, dynamic> json) =>
    CommentCreated(
      json['authorUserId'] as String,
      json['text'] as String,
      json['parentTweetId'] as String,
      json['parentCommentId'] as String,
    );

Map<String, dynamic> _$CommentCreatedToJson(CommentCreated instance) =>
    <String, dynamic>{
      'authorUserId': instance.authorUserId,
      'text': instance.text,
      'parentTweetId': instance.parentTweetId,
      'parentCommentId': instance.parentCommentId,
    };

ToggleCommentLike _$ToggleCommentLikeFromJson(Map<String, dynamic> json) =>
    ToggleCommentLike(json['userId'] as String);

Map<String, dynamic> _$ToggleCommentLikeToJson(ToggleCommentLike instance) =>
    <String, dynamic>{'userId': instance.userId};

CommentLiked _$CommentLikedFromJson(Map<String, dynamic> json) =>
    CommentLiked(json['userId'] as String);

Map<String, dynamic> _$CommentLikedToJson(CommentLiked instance) =>
    <String, dynamic>{'userId': instance.userId};

CommentUnliked _$CommentUnlikedFromJson(Map<String, dynamic> json) =>
    CommentUnliked(json['userId'] as String);

Map<String, dynamic> _$CommentUnlikedToJson(CommentUnliked instance) =>
    <String, dynamic>{'userId': instance.userId};

AddCommentReply _$AddCommentReplyFromJson(Map<String, dynamic> json) =>
    AddCommentReply(json['replyCommentId'] as String);

Map<String, dynamic> _$AddCommentReplyToJson(AddCommentReply instance) =>
    <String, dynamic>{'replyCommentId': instance.replyCommentId};

CommentReplyAdded _$CommentReplyAddedFromJson(Map<String, dynamic> json) =>
    CommentReplyAdded(json['replyCommentId'] as String);

Map<String, dynamic> _$CommentReplyAddedToJson(CommentReplyAdded instance) =>
    <String, dynamic>{'replyCommentId': instance.replyCommentId};
