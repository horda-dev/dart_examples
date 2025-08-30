// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCounterCommand _$CreateCounterCommandFromJson(
  Map<String, dynamic> json,
) => CreateCounterCommand(
  name: json['name'] as String,
  initialValue: (json['initialValue'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CreateCounterCommandToJson(
  CreateCounterCommand instance,
) => <String, dynamic>{
  'name': instance.name,
  'initialValue': instance.initialValue,
};

DeleteCounterCommand _$DeleteCounterCommandFromJson(
  Map<String, dynamic> json,
) => DeleteCounterCommand();

Map<String, dynamic> _$DeleteCounterCommandToJson(
  DeleteCounterCommand instance,
) => <String, dynamic>{};

IncrementCounterCommand _$IncrementCounterCommandFromJson(
  Map<String, dynamic> json,
) => IncrementCounterCommand(amount: (json['amount'] as num?)?.toInt() ?? 1);

Map<String, dynamic> _$IncrementCounterCommandToJson(
  IncrementCounterCommand instance,
) => <String, dynamic>{'amount': instance.amount};

DecrementCounterCommand _$DecrementCounterCommandFromJson(
  Map<String, dynamic> json,
) => DecrementCounterCommand(amount: (json['amount'] as num?)?.toInt() ?? 1);

Map<String, dynamic> _$DecrementCounterCommandToJson(
  DecrementCounterCommand instance,
) => <String, dynamic>{'amount': instance.amount};

FreezeCounterCommand _$FreezeCounterCommandFromJson(
  Map<String, dynamic> json,
) => FreezeCounterCommand();

Map<String, dynamic> _$FreezeCounterCommandToJson(
  FreezeCounterCommand instance,
) => <String, dynamic>{};

UnfreezeCounterCommand _$UnfreezeCounterCommandFromJson(
  Map<String, dynamic> json,
) => UnfreezeCounterCommand();

Map<String, dynamic> _$UnfreezeCounterCommandToJson(
  UnfreezeCounterCommand instance,
) => <String, dynamic>{};

CounterCreatedEvent _$CounterCreatedEventFromJson(Map<String, dynamic> json) =>
    CounterCreatedEvent(
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$CounterCreatedEventToJson(
  CounterCreatedEvent instance,
) => <String, dynamic>{'name': instance.name, 'count': instance.count};

CounterDeletedEvent _$CounterDeletedEventFromJson(Map<String, dynamic> json) =>
    CounterDeletedEvent();

Map<String, dynamic> _$CounterDeletedEventToJson(
  CounterDeletedEvent instance,
) => <String, dynamic>{};

CounterIncrementedEvent _$CounterIncrementedEventFromJson(
  Map<String, dynamic> json,
) => CounterIncrementedEvent(amount: (json['amount'] as num).toInt());

Map<String, dynamic> _$CounterIncrementedEventToJson(
  CounterIncrementedEvent instance,
) => <String, dynamic>{'amount': instance.amount};

CounterDecrementedEvent _$CounterDecrementedEventFromJson(
  Map<String, dynamic> json,
) => CounterDecrementedEvent(amount: (json['amount'] as num).toInt());

Map<String, dynamic> _$CounterDecrementedEventToJson(
  CounterDecrementedEvent instance,
) => <String, dynamic>{'amount': instance.amount};

CounterFreezeChangedEvent _$CounterFreezeChangedEventFromJson(
  Map<String, dynamic> json,
) => CounterFreezeChangedEvent(newValue: json['newValue'] as bool);

Map<String, dynamic> _$CounterFreezeChangedEventToJson(
  CounterFreezeChangedEvent instance,
) => <String, dynamic>{'newValue': instance.newValue};
