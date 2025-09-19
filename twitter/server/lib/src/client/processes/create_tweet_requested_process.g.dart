// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tweet_requested_process.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
