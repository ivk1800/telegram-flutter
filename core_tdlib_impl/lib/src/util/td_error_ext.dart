import 'dart:async';

import 'package:td_api/td_api.dart' as td;
import 'package:td_client/td_client.dart';

extension TdErrorExt<T extends td.TdObject> on Future<T> {
  Future<T> catchTdError() {
    return catchError(
      // TODO: check correct handle errors
      Error.throwWithStackTrace,
      test: (Object error) => error is TdFunctionException,
    );
  }
}
