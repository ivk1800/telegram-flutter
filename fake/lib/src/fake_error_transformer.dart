import 'package:error_transformer_api/error_transformer_api.dart';

class FakeErrorTransformer implements IErrorTransformer {
  const FakeErrorTransformer();

  @override
  String transformToString(Object error) => error.toString();
}
