import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class OptionsManager {
  OptionsManager({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  Future<void> setOnline({required bool online}) {
    return _functionExecutor.send<td.Ok>(td.SetOption(
      name: 'online',
      value: td.OptionValueBoolean(value: online),
    ));
  }
}
