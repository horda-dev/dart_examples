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
    if (_containsBadWords(cmd.text)) {
      return TextModerationCompleted(
        false,
        'Contains forbidden words.',
        cmd.text,
      );
    }

    return TextModerationCompleted(true, '', cmd.text);
  }

  @override
  void initHandlers(ServiceHandlers handlers) {
    handlers.add<ModerateText>(moderateText, ModerateText.fromJson);
  }

  bool _containsBadWords(String text) {
    final textInLower = text.toLowerCase();

    return [
      'shit',
      'fuck',
      'bitch',
    ].any(
      (badWord) => textInLower.contains(badWord),
    );
  }
}
