import 'package:horda_server/horda_server.dart';
import 'package:xid/xid.dart';

import 'messages.dart';

/// Sends notifications to users
///
/// {@category Service}
class NotificationService extends Service {
  /// For command description, see [SendPushNotification].
  Future<RemoteEvent> sendPushNotification(
    SendPushNotification cmd,
    ServiceContext context,
  ) async {
    // For the sake of the example we just wait for a second.
    await Future.delayed(const Duration(seconds: 1));

    return PushNotificationSent(Xid().toString(), cmd.userId, true);
  }

  /// For command description, see [SendUserRegistrationEmail].
  Future<RemoteEvent> sendUserRegistrationEmail(
    SendUserRegistrationEmail cmd,
    ServiceContext context,
  ) async {
    // For the sake of the example we just wait for a second.
    await Future.delayed(const Duration(seconds: 1));

    return UserRegistrationEmailSent(
      cmd.userId,
      cmd.email,
      DateTime.now().toUtc(),
    );
  }

  @override
  void initHandlers(ServiceHandlers handlers) {
    handlers.add<SendPushNotification>(
      sendPushNotification,
      SendPushNotification.fromJson,
    );
    handlers.add<SendUserRegistrationEmail>(
      sendUserRegistrationEmail,
      SendUserRegistrationEmail.fromJson,
    );
  }
}
