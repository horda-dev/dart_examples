// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccountEntityState _$UserAccountEntityStateFromJson(
  Map<String, dynamic> json,
) => UserAccountEntityState._json(
  (json['following'] as List<dynamic>).map((e) => e as String).toList(),
  (json['followers'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$UserAccountEntityStateToJson(
  UserAccountEntityState instance,
) => <String, dynamic>{
  'following': instance._following,
  'followers': instance._followers,
};
