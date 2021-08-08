import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

extension TdErrorExt<T extends td.TdObject> on Future<T> {
  Future<T> catchTdError() {
    return catchError(
      (Object error) {
        error as TdFunctionError;
        throw TdError(error: error.error, function: error.function);
      },
      test: (Object error) => error is TdFunctionError,
    );
  }
}
