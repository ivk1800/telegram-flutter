import 'dart:async';

import 'package:td_api/td_api.dart' as td;
import 'package:td_client/td_client.dart';

extension TdErrorExt<T extends td.TdObject> on Future<T> {
  Future<T> catchTdError() {
    return catchError(
      (Object error) {
        error as TdFunctionException;
        Error.throwWithStackTrace(error, error.stackTrace!);
      },
      test: (Object error) => error is TdFunctionException,
    );
  }
}
