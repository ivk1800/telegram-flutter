import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:td_client/td_client.dart';

class TdErrorTransformer implements IErrorTransformer {
  @override
  String transformToString(Object error) {
    if (error is TdFunctionException) {
      return error.error.message;
    }
    return error.toString();
  }
}
