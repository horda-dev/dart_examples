// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCounterList _$CreateCounterListFromJson(Map<String, dynamic> json) =>
    CreateCounterList();

Map<String, dynamic> _$CreateCounterListToJson(CreateCounterList instance) =>
    <String, dynamic>{};

CounterListCreated _$CounterListCreatedFromJson(Map<String, dynamic> json) =>
    CounterListCreated();

Map<String, dynamic> _$CounterListCreatedToJson(CounterListCreated instance) =>
    <String, dynamic>{};

AddCounterToList _$AddCounterToListFromJson(Map<String, dynamic> json) =>
    AddCounterToList(counterId: json['counterId'] as String);

Map<String, dynamic> _$AddCounterToListToJson(AddCounterToList instance) =>
    <String, dynamic>{'counterId': instance.counterId};

RemoveCounterFromList _$RemoveCounterFromListFromJson(
  Map<String, dynamic> json,
) => RemoveCounterFromList(counterId: json['counterId'] as String);

Map<String, dynamic> _$RemoveCounterFromListToJson(
  RemoveCounterFromList instance,
) => <String, dynamic>{'counterId': instance.counterId};

CounterAddedToList _$CounterAddedToListFromJson(Map<String, dynamic> json) =>
    CounterAddedToList(counterId: json['counterId'] as String);

Map<String, dynamic> _$CounterAddedToListToJson(CounterAddedToList instance) =>
    <String, dynamic>{'counterId': instance.counterId};

CounterRemovedFromList _$CounterRemovedFromListFromJson(
  Map<String, dynamic> json,
) => CounterRemovedFromList(counterId: json['counterId'] as String);

Map<String, dynamic> _$CounterRemovedFromListToJson(
  CounterRemovedFromList instance,
) => <String, dynamic>{'counterId': instance.counterId};
