import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';

class FakeOptionsManager extends OptionsManager {
  const FakeOptionsManager({
    required ITdFunctionExecutor functionExecutor,
  }) : super(functionExecutor: functionExecutor);

  @override
  Future<int> getMyId() async => 0;
}
