import 'package:core/core.dart';

class FakeOptionsManager extends OptionsManager {
  const FakeOptionsManager({
    required super.functionExecutor,
  });

  @override
  Future<int> getMyId() async => 0;
}
