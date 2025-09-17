// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentEntityState _$CommentEntityStateFromJson(Map<String, dynamic> json) =>
    CommentEntityState._json(
      json['authorUserId'] as String,
      json['text'] as String,
      json['parentTweetId'] as String,
      json['parentCommentId'] as String?,
      (json['likedByUsers'] as List<dynamic>).map((e) => e as String).toList(),
      (json['replyCommentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CommentEntityStateToJson(CommentEntityState instance) =>
    <String, dynamic>{
      'authorUserId': instance.authorUserId,
      'text': instance.text,
      'parentTweetId': instance.parentTweetId,
      'parentCommentId': instance.parentCommentId,
      'createdAt': instance.createdAt.toIso8601String(),
      'likedByUsers': instance._likedByUsers,
      'replyCommentIds': instance._replyCommentIds,
    };
