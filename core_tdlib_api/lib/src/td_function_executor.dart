import 'package:tdlib/td_api.dart' as td;

abstract class ITdFunctionExecutor {
  Future<T> send<T extends td.TdObject>(td.TdFunction object);

  T execute<T extends td.TdObject>(td.TdFunction object);
}
