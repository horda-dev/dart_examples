// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCounterRequested _$CreateCounterRequestedFromJson(
  Map<String, dynamic> json,
) => CreateCounterRequested(
  name: json['name'] as String,
  initialValue: (json['initialValue'] as num).toInt(),
);

Map<String, dynamic> _$CreateCounterRequestedToJson(
  CreateCounterRequested instance,
) => <String, dynamic>{
  'name': instance.name,
  'initialValue': instance.initialValue,
};

DeleteCounterRequested _$DeleteCounterRequestedFromJson(
  Map<String, dynamic> json,
) => DeleteCounterRequested(counterId: json['counterId'] as String);

Map<String, dynamic> _$DeleteCounterRequestedToJson(
  DeleteCounterRequested instance,
) => <String, dynamic>{'counterId': instance.counterId};

IncrementCounterRequested _$IncrementCounterRequestedFromJson(
  Map<String, dynamic> json,
) => IncrementCounterRequested(
  counterId: json['counterId'] as String,
  amount: (json['amount'] as num).toInt(),
);

Map<String, dynamic> _$IncrementCounterRequestedToJson(
  IncrementCounterRequested instance,
) => <String, dynamic>{
  'counterId': instance.counterId,
  'amount': instance.amount,
};

DecrementCounterRequested _$DecrementCounterRequestedFromJson(
  Map<String, dynamic> json,
) => DecrementCounterRequested(
  counterId: json['counterId'] as String,
  amount: (json['amount'] as num).toInt(),
);

Map<String, dynamic> _$DecrementCounterRequestedToJson(
  DecrementCounterRequested instance,
) => <String, dynamic>{
  'counterId': instance.counterId,
  'amount': instance.amount,
};

FreezeCounterRequested _$FreezeCounterRequestedFromJson(
  Map<String, dynamic> json,
) => FreezeCounterRequested(counterId: json['counterId'] as String);

Map<String, dynamic> _$FreezeCounterRequestedToJson(
  FreezeCounterRequested instance,
) => <String, dynamic>{'counterId': instance.counterId};

UnfreezeCounterRequested _$UnfreezeCounterRequestedFromJson(
  Map<String, dynamic> json,
) => UnfreezeCounterRequested(counterId: json['counterId'] as String);

Map<String, dynamic> _$UnfreezeCounterRequestedToJson(
  UnfreezeCounterRequested instance,
) => <String, dynamic>{'counterId': instance.counterId};

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
) => CounterIncrementedEvent(newValue: (json['newValue'] as num).toInt());

Map<String, dynamic> _$CounterIncrementedEventToJson(
  CounterIncrementedEvent instance,
) => <String, dynamic>{'newValue': instance.newValue};

CounterDecrementedEvent _$CounterDecrementedEventFromJson(
  Map<String, dynamic> json,
) => CounterDecrementedEvent(newValue: (json['newValue'] as num).toInt());

Map<String, dynamic> _$CounterDecrementedEventToJson(
  CounterDecrementedEvent instance,
) => <String, dynamic>{'newValue': instance.newValue};

CounterFreezeChangedEvent _$CounterFreezeChangedEventFromJson(
  Map<String, dynamic> json,
) => CounterFreezeChangedEvent(newValue: json['newValue'] as bool);

Map<String, dynamic> _$CounterFreezeChangedEventToJson(
  CounterFreezeChangedEvent instance,
) => <String, dynamic>{'newValue': instance.newValue};
