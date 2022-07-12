import 'package:td_api/td_api.dart' as td;

class TdError extends Error {
  TdError({
    required this.error,
    required this.function,
  });

  final td.TdFunction function;
  final td.TdError error;

  @override
  String toString() =>
      'TdError(function: ${function.toJson()}, error: ${error.toJson()})';
}
