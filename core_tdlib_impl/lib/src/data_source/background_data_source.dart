import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class BackgroundDataSource {
  BackgroundDataSource({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  Future<List<td.Background>> get backgrounds => _functionExecutor
      .send<td.Backgrounds>(const td.GetBackgrounds(forDarkTheme: false))
      .then((td.Backgrounds value) => value.backgrounds);
}
