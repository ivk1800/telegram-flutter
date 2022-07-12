import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeTdFunctionExecutor implements ITdFunctionExecutor {
  FakeTdFunctionExecutor({required this.resultFactory});

  Future<td.TdObject> Function(td.TdFunction object) resultFactory;

  @override
  T execute<T extends td.TdObject>(td.TdFunction object) {
    throw Error();
  }

  @override
  Future<T> send<T extends td.TdObject>(td.TdFunction object) async {
    final td.TdObject tdObject = await resultFactory.call(object);
    return tdObject as T;
  }
}
