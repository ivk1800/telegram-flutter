library tg_logger_api;

abstract class ILogger {
  void d({
    required Object o,
    String? tag,
  });
}
