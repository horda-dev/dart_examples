// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCounter _$CreateCounterFromJson(Map<String, dynamic> json) =>
    CreateCounter(
      name: json['name'] as String,
      initialValue: (json['initialValue'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CreateCounterToJson(CreateCounter instance) =>
    <String, dynamic>{
      'name': instance.name,
      'initialValue': instance.initialValue,
    };

DeleteCounter _$DeleteCounterFromJson(Map<String, dynamic> json) =>
    DeleteCounter();

Map<String, dynamic> _$DeleteCounterToJson(DeleteCounter instance) =>
    <String, dynamic>{};

IncrementCounter _$IncrementCounterFromJson(Map<String, dynamic> json) =>
    IncrementCounter(amount: (json['amount'] as num?)?.toInt() ?? 1);

Map<String, dynamic> _$IncrementCounterToJson(IncrementCounter instance) =>
    <String, dynamic>{'amount': instance.amount};

DecrementCounter _$DecrementCounterFromJson(Map<String, dynamic> json) =>
    DecrementCounter(amount: (json['amount'] as num?)?.toInt() ?? 1);

Map<String, dynamic> _$DecrementCounterToJson(DecrementCounter instance) =>
    <String, dynamic>{'amount': instance.amount};

FreezeCounter _$FreezeCounterFromJson(Map<String, dynamic> json) =>
    FreezeCounter();

Map<String, dynamic> _$FreezeCounterToJson(FreezeCounter instance) =>
    <String, dynamic>{};

UnfreezeCounter _$UnfreezeCounterFromJson(Map<String, dynamic> json) =>
    UnfreezeCounter();

Map<String, dynamic> _$UnfreezeCounterToJson(UnfreezeCounter instance) =>
    <String, dynamic>{};

CounterCreated _$CounterCreatedFromJson(Map<String, dynamic> json) =>
    CounterCreated(
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$CounterCreatedToJson(CounterCreated instance) =>
    <String, dynamic>{'name': instance.name, 'count': instance.count};

CounterDeleted _$CounterDeletedFromJson(Map<String, dynamic> json) =>
    CounterDeleted();

Map<String, dynamic> _$CounterDeletedToJson(CounterDeleted instance) =>
    <String, dynamic>{};

CounterIncremented _$CounterIncrementedFromJson(Map<String, dynamic> json) =>
    CounterIncremented(amount: (json['amount'] as num).toInt());

Map<String, dynamic> _$CounterIncrementedToJson(CounterIncremented instance) =>
    <String, dynamic>{'amount': instance.amount};

CounterDecremented _$CounterDecrementedFromJson(Map<String, dynamic> json) =>
    CounterDecremented(amount: (json['amount'] as num).toInt());

Map<String, dynamic> _$CounterDecrementedToJson(CounterDecremented instance) =>
    <String, dynamic>{'amount': instance.amount};

CounterFreezeChanged _$CounterFreezeChangedFromJson(
  Map<String, dynamic> json,
) => CounterFreezeChanged(newValue: json['newValue'] as bool);

Map<String, dynamic> _$CounterFreezeChangedToJson(
  CounterFreezeChanged instance,
) => <String, dynamic>{'newValue': instance.newValue};
