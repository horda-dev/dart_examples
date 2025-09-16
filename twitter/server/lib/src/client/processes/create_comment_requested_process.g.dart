// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_comment_requested_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientCreateCommentRequested _$ClientCreateCommentRequestedFromJson(
  Map<String, dynamic> json,
) => ClientCreateCommentRequested(
  authorUserId: json['authorUserId'] as String,
  text: json['text'] as String,
  parentTweetId: json['parentTweetId'] as String,
  parentCommentId: json['parentCommentId'] as String?,
);

Map<String, dynamic> _$ClientCreateCommentRequestedToJson(
  ClientCreateCommentRequested instance,
) => <String, dynamic>{
  'authorUserId': instance.authorUserId,
  'text': instance.text,
  'parentTweetId': instance.parentTweetId,
  'parentCommentId': instance.parentCommentId,
};
