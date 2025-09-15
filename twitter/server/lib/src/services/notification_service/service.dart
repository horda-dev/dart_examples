import 'package:horda_server/horda_server.dart';

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
    // TODO: implement SendPushNotification handler
    throw UnimplementedError('SendPushNotification handler is not implemented');
  }

  /// For command description, see [SendUserRegistrationEmail].
  Future<RemoteEvent> sendUserRegistrationEmail(
    SendUserRegistrationEmail cmd,
    ServiceContext context,
  ) async {
    // TODO: implement SendUserRegistrationEmail handler
    throw UnimplementedError(
      'SendUserRegistrationEmail handler is not implemented',
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

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
