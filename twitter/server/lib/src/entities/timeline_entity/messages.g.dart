// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTimeline _$CreateTimelineFromJson(Map<String, dynamic> json) =>
    CreateTimeline(json['ownerUserId'] as String);

Map<String, dynamic> _$CreateTimelineToJson(CreateTimeline instance) =>
    <String, dynamic>{'ownerUserId': instance.ownerUserId};

TimelineCreated _$TimelineCreatedFromJson(Map<String, dynamic> json) =>
    TimelineCreated(json['ownerUserId'] as String);

Map<String, dynamic> _$TimelineCreatedToJson(TimelineCreated instance) =>
    <String, dynamic>{'ownerUserId': instance.ownerUserId};

AddTweetToTimeline _$AddTweetToTimelineFromJson(Map<String, dynamic> json) =>
    AddTweetToTimeline(json['tweetId'] as String);

Map<String, dynamic> _$AddTweetToTimelineToJson(AddTweetToTimeline instance) =>
    <String, dynamic>{'tweetId': instance.tweetId};

TweetAddedToTimeline _$TweetAddedToTimelineFromJson(
  Map<String, dynamic> json,
) => TweetAddedToTimeline(json['tweetId'] as String);

Map<String, dynamic> _$TweetAddedToTimelineToJson(
  TweetAddedToTimeline instance,
) => <String, dynamic>{'tweetId': instance.tweetId};
