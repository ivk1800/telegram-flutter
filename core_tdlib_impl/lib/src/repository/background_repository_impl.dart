import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class BackgroundRepositoryImpl implements IBackgroundRepository {
  BackgroundRepositoryImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<List<td.Background>> get backgrounds => _functionExecutor
      .send<td.Backgrounds>(const td.GetBackgrounds(forDarkTheme: false))
      .then((td.Backgrounds value) => value.backgrounds);
}
