// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentEntityState _$CommentEntityStateFromJson(Map<String, dynamic> json) =>
    CommentEntityState._json(
      (json['likedByUsers'] as List<dynamic>).map((e) => e as String).toList(),
      (json['replyCommentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CommentEntityStateToJson(CommentEntityState instance) =>
    <String, dynamic>{
      'likedByUsers': instance._likedByUsers,
      'replyCommentIds': instance._replyCommentIds,
    };
