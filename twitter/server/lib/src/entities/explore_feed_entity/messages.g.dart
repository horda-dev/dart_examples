// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateExploreFeed _$CreateExploreFeedFromJson(Map<String, dynamic> json) =>
    CreateExploreFeed();

Map<String, dynamic> _$CreateExploreFeedToJson(CreateExploreFeed instance) =>
    <String, dynamic>{};

ExploreFeedCreated _$ExploreFeedCreatedFromJson(Map<String, dynamic> json) =>
    ExploreFeedCreated();

Map<String, dynamic> _$ExploreFeedCreatedToJson(ExploreFeedCreated instance) =>
    <String, dynamic>{};

AddTweetToExploreFeed _$AddTweetToExploreFeedFromJson(
  Map<String, dynamic> json,
) => AddTweetToExploreFeed(json['tweetId'] as String);

Map<String, dynamic> _$AddTweetToExploreFeedToJson(
  AddTweetToExploreFeed instance,
) => <String, dynamic>{'tweetId': instance.tweetId};

TweetAddedToExploreFeed _$TweetAddedToExploreFeedFromJson(
  Map<String, dynamic> json,
) => TweetAddedToExploreFeed(json['tweetId'] as String);

Map<String, dynamic> _$TweetAddedToExploreFeedToJson(
  TweetAddedToExploreFeed instance,
) => <String, dynamic>{'tweetId': instance.tweetId};
