// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCounterToList _$AddCounterToListFromJson(Map<String, dynamic> json) =>
    AddCounterToList(counterId: json['counterId'] as String);

Map<String, dynamic> _$AddCounterToListToJson(AddCounterToList instance) =>
    <String, dynamic>{'counterId': instance.counterId};

RemoveCounterFromList _$RemoveCounterFromListFromJson(
  Map<String, dynamic> json,
) => RemoveCounterFromList(counterKey: json['counterKey'] as String);

Map<String, dynamic> _$RemoveCounterFromListToJson(
  RemoveCounterFromList instance,
) => <String, dynamic>{'counterKey': instance.counterKey};

CounterAddedToList _$CounterAddedToListFromJson(Map<String, dynamic> json) =>
    CounterAddedToList(counterId: json['counterId'] as String);

Map<String, dynamic> _$CounterAddedToListToJson(CounterAddedToList instance) =>
    <String, dynamic>{'counterId': instance.counterId};

CounterRemovedFromList _$CounterRemovedFromListFromJson(
  Map<String, dynamic> json,
) => CounterRemovedFromList(counterKey: json['counterKey'] as String);

Map<String, dynamic> _$CounterRemovedFromListToJson(
  CounterRemovedFromList instance,
) => <String, dynamic>{'counterKey': instance.counterKey};
