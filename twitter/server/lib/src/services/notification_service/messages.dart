import 'package:horda_server/horda_server.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

/// Sends push notification to a user.
///
/// {@category Service Command}
@JsonSerializable()
class SendPushNotification extends RemoteCommand {
  SendPushNotification(this.userId, this.message, this.type);

  /// ID of the user to notify
  String userId;

  /// notification message text
  String message;

  /// type of notification
  String type;

  factory SendPushNotification.fromJson(Map<String, dynamic> json) {
    return _$SendPushNotificationFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$SendPushNotificationToJson(this);
  }
}

/// Push notification was successfully sent.
///
/// {@category Service Event}
@JsonSerializable()
class PushNotificationSent extends RemoteEvent {
  PushNotificationSent(this.notificationId, this.userId, this.delivered);

  /// ID of the sent notification
  String notificationId;

  /// ID of the user who received the notification
  String userId;

  /// whether notification was delivered
  bool delivered;

  factory PushNotificationSent.fromJson(Map<String, dynamic> json) {
    return _$PushNotificationSentFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$PushNotificationSentToJson(this);
  }
}

/// Sends a user registration confirmation email.
///
/// {@category Service Command}
@JsonSerializable()
class SendUserRegistrationEmail extends RemoteCommand {
  SendUserRegistrationEmail(this.userId, this.email, this.displayName);

  /// ID of the registered user
  String userId;

  /// Email address of the user
  String email;

  /// Display name of the user
  String displayName;

  factory SendUserRegistrationEmail.fromJson(Map<String, dynamic> json) {
    return _$SendUserRegistrationEmailFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$SendUserRegistrationEmailToJson(this);
  }
}

/// Event indicating user registration email has been sent.
///
/// {@category Service Event}
@JsonSerializable()
class UserRegistrationEmailSent extends RemoteEvent {
  UserRegistrationEmailSent(this.userId, this.email, this.sentAt);

  /// ID of the registered user
  String userId;

  /// Email address of the user
  String email;

  /// Timestamp when email was sent
  DateTime sentAt;

  factory UserRegistrationEmailSent.fromJson(Map<String, dynamic> json) {
    return _$UserRegistrationEmailSentFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UserRegistrationEmailSentToJson(this);
  }
}
