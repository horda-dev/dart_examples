// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TweetEntityState _$TweetEntityStateFromJson(Map<String, dynamic> json) =>
    TweetEntityState._json(
      (json['retweetedByUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      (json['likedByUsers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TweetEntityStateToJson(TweetEntityState instance) =>
    <String, dynamic>{
      'retweetedByUsers': instance._retweetedByUsers,
      'likedByUsers': instance._likedByUsers,
    };
