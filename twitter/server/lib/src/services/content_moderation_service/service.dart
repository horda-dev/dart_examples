import 'package:horda_server/horda_server.dart';

import 'messages.dart';

/// Validates and moderates text content for inappropriate material
///
/// {@category Service}
class ContentModerationService extends Service {
  /// For command description, see [ModerateText].
  Future<RemoteEvent> moderateText(
    ModerateText cmd,
    ServiceContext context,
  ) async {
    // TODO: implement moderateText handler
    throw UnimplementedError('moderateText handler is not implemented');
  }

  @override
  void initHandlers(ServiceHandlers handlers) {
    handlers.add<ModerateText>(moderateText, ModerateText.fromJson);
  }

  @override
  void initMigrations(EntityStateMigrations migrations) {}
}
