// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TweetEntityState _$TweetEntityStateFromJson(Map<String, dynamic> json) =>
    TweetEntityState._json(
      (json['likedByUsers'] as List<dynamic>).map((e) => e as String).toList(),
      (json['retweetedByUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$TweetEntityStateToJson(TweetEntityState instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'likedByUsers': instance._likedByUsers,
      'retweetedByUsers': instance._retweetedByUsers,
    };
