// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounterListState _$CounterListStateFromJson(Map<String, dynamic> json) =>
    CounterListState(
      counterIds: (json['counterIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CounterListStateToJson(CounterListState instance) =>
    <String, dynamic>{'counterIds': instance.counterIds};
