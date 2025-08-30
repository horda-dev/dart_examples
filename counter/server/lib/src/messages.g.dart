// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCounterListRequested _$CreateCounterListRequestedFromJson(
  Map<String, dynamic> json,
) => CreateCounterListRequested();

Map<String, dynamic> _$CreateCounterListRequestedToJson(
  CreateCounterListRequested instance,
) => <String, dynamic>{};

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

ValidateCounterName _$ValidateCounterNameFromJson(Map<String, dynamic> json) =>
    ValidateCounterName(name: json['name'] as String);

Map<String, dynamic> _$ValidateCounterNameToJson(
  ValidateCounterName instance,
) => <String, dynamic>{'name': instance.name};

CounterNameValidated _$CounterNameValidatedFromJson(
  Map<String, dynamic> json,
) => CounterNameValidated(
  isValid: json['isValid'] as bool,
  invalidReason: json['invalidReason'] as String,
);

Map<String, dynamic> _$CounterNameValidatedToJson(
  CounterNameValidated instance,
) => <String, dynamic>{
  'isValid': instance.isValid,
  'invalidReason': instance.invalidReason,
};
