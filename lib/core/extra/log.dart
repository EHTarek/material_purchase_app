import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract class Log {
  void info({required String title, required dynamic msg});

  void warning({required String title, required dynamic msg});

  void exception({required String title, required dynamic msg});

  void error({required String title, required dynamic msg});

  void debug({required String title, required dynamic msg});

  void blocObserver({required String title, required dynamic msg});

  void verbose({required String title, required dynamic msg});
}

class LogImpl extends Log {
  final logger = Logger(
    filter: MyLogFilter(),
    printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5, lineLength: 150),
  );

  @override
  info({required String title, required dynamic msg}) {
    logger.i('INFO:: $title\n$msg');
  }

  @override
  warning({required String title, required dynamic msg}) {
    logger.w('WARNING:: $title\n$msg');
  }

  @override
  exception({required String title, required dynamic msg}) {
    logger.f('Exception:: $title\n$msg');
  }

  @override
  error({required String title, required dynamic msg}) {
    logger.e('ERROR:: $title\n$msg');
  }

  @override
  debug({required String title, required dynamic msg}) {
    logger.d('DEBUG:: $title\n$msg');
  }

  @override
  blocObserver({required String title, required dynamic msg}) {
    logger.t('Business Logic:: $title\n$msg');
  }

  @override
  verbose({required String title, required dynamic msg}) {
    logger.t('Verbose:: $title\n$msg');
  }
}

class MyLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (kDebugMode) return true;

    // return true;
    return false;
  }
}
