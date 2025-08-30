// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCounterListCommand _$CreateCounterListCommandFromJson(
  Map<String, dynamic> json,
) => CreateCounterListCommand();

Map<String, dynamic> _$CreateCounterListCommandToJson(
  CreateCounterListCommand instance,
) => <String, dynamic>{};

CounterListCreatedEvent _$CounterListCreatedEventFromJson(
  Map<String, dynamic> json,
) => CounterListCreatedEvent();

Map<String, dynamic> _$CounterListCreatedEventToJson(
  CounterListCreatedEvent instance,
) => <String, dynamic>{};

AddCounterToListCommand _$AddCounterToListCommandFromJson(
  Map<String, dynamic> json,
) => AddCounterToListCommand(counterId: json['counterId'] as String);

Map<String, dynamic> _$AddCounterToListCommandToJson(
  AddCounterToListCommand instance,
) => <String, dynamic>{'counterId': instance.counterId};

RemoveCounterFromListCommand _$RemoveCounterFromListCommandFromJson(
  Map<String, dynamic> json,
) => RemoveCounterFromListCommand(counterId: json['counterId'] as String);

Map<String, dynamic> _$RemoveCounterFromListCommandToJson(
  RemoveCounterFromListCommand instance,
) => <String, dynamic>{'counterId': instance.counterId};

CounterAddedToListEvent _$CounterAddedToListEventFromJson(
  Map<String, dynamic> json,
) => CounterAddedToListEvent(counterId: json['counterId'] as String);

Map<String, dynamic> _$CounterAddedToListEventToJson(
  CounterAddedToListEvent instance,
) => <String, dynamic>{'counterId': instance.counterId};

CounterRemovedFromListEvent _$CounterRemovedFromListEventFromJson(
  Map<String, dynamic> json,
) => CounterRemovedFromListEvent(counterId: json['counterId'] as String);

Map<String, dynamic> _$CounterRemovedFromListEventToJson(
  CounterRemovedFromListEvent instance,
) => <String, dynamic>{'counterId': instance.counterId};
