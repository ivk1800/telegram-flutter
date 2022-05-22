// ignore_for_file: avoid_print

import 'package:tg_logger_api/tg_logger_api.dart';

class TgLoggerImpl implements ILogger {
  @override
  void d({required Object o, String? tag}) {
    print(o);
  }
}
