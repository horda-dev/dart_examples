// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModerateText _$ModerateTextFromJson(Map<String, dynamic> json) =>
    ModerateText(json['text'] as String);

Map<String, dynamic> _$ModerateTextToJson(ModerateText instance) =>
    <String, dynamic>{'text': instance.text};

TextModerationCompleted _$TextModerationCompletedFromJson(
  Map<String, dynamic> json,
) => TextModerationCompleted(
  json['isValid'] as bool,
  json['reason'] as String,
  json['originalText'] as String,
);

Map<String, dynamic> _$TextModerationCompletedToJson(
  TextModerationCompleted instance,
) => <String, dynamic>{
  'isValid': instance.isValid,
  'reason': instance.reason,
  'originalText': instance.originalText,
};
