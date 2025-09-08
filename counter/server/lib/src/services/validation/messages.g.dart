// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
