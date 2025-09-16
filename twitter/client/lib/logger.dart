import 'dart:developer' as developer;

import 'package:logging/logging.dart';

class AppLogger {
  static void init() {
    hierarchicalLoggingEnabled = true;

    Logger.root.level = Level.ALL;
    Logger('Messaging').level = Level.ALL;
    Logger('Query').level = Level.ALL;
    Logger('Flow').level = Level.ALL;
    Logger('Script').level = Level.ALL;
    Logger('Fluir.System').level = Level.ALL;
    Logger('Fluir.Connection').level = Level.ALL;
    Logger('Fluir.MessageStore').level = Level.ALL;

    Logger.root.onRecord.listen((r) {
      var msg = '${r.loggerName}: ${r.message}';

      if (r.level < Level.WARNING) {
        msg = Printer.white(msg);
      } else if (r.level < Level.SEVERE) {
        msg = Printer.yellow(msg);
      } else {
        msg = Printer.red(msg);
      }

      developer.log(msg);
    });
  }
}

class Printer {
  static String black(String msg) {
    return '\u001b[30m$msg\u001b[0m';
  }

  static String red(String msg) {
    return '\u001b[31m$msg\u001b[0m';
  }

  static String green(String msg) {
    return '\u001b[32m$msg\u001b[0m';
  }

  static String yellow(String msg) {
    return '\u001b[33m$msg\u001b[0m';
  }

  static String blue(String msg) {
    return '\u001b[34m$msg\u001b[0m';
  }

  static String white(String msg) {
    return '\u001b[37m$msg\u001b[0m';
  }
}

// https://stackoverflow.com/questions/54018071/how-to-call-print-with-colorful-text-to-android-studio-console-in-flutter
// Black:   \x1B[30m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Magenta: \x1B[35m
// Cyan:    \x1B[36m
// White:   \x1B[37m
// Reset:   \x1B[0m
