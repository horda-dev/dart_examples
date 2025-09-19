// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendPushNotification _$SendPushNotificationFromJson(
  Map<String, dynamic> json,
) => SendPushNotification(
  json['userId'] as String,
  json['message'] as String,
  json['type'] as String,
);

Map<String, dynamic> _$SendPushNotificationToJson(
  SendPushNotification instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'message': instance.message,
  'type': instance.type,
};

PushNotificationSent _$PushNotificationSentFromJson(
  Map<String, dynamic> json,
) => PushNotificationSent(
  json['notificationId'] as String,
  json['userId'] as String,
  json['delivered'] as bool,
);

Map<String, dynamic> _$PushNotificationSentToJson(
  PushNotificationSent instance,
) => <String, dynamic>{
  'notificationId': instance.notificationId,
  'userId': instance.userId,
  'delivered': instance.delivered,
};

SendUserRegistrationEmail _$SendUserRegistrationEmailFromJson(
  Map<String, dynamic> json,
) => SendUserRegistrationEmail(
  json['userId'] as String,
  json['email'] as String,
  json['displayName'] as String,
);

Map<String, dynamic> _$SendUserRegistrationEmailToJson(
  SendUserRegistrationEmail instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'email': instance.email,
  'displayName': instance.displayName,
};

UserRegistrationEmailSent _$UserRegistrationEmailSentFromJson(
  Map<String, dynamic> json,
) => UserRegistrationEmailSent(
  json['userId'] as String,
  json['email'] as String,
  DateTime.parse(json['sentAt'] as String),
);

Map<String, dynamic> _$UserRegistrationEmailSentToJson(
  UserRegistrationEmailSent instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'email': instance.email,
  'sentAt': instance.sentAt.toIso8601String(),
};
