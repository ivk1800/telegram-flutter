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

  Future<int> getMyId() => _getInt('my_id');

  Future<int> _getInt(String name) {
    return _functionExecutor
        .send<td.OptionValue>(td.GetOption(name: name))
        .then(
          (td.OptionValue value) => value.map(
            $boolean: (_) => throw StateError('unexpected option type'),
            empty: (_) => throw StateError('unexpected option type'),
            integer: (td.OptionValueInteger option) => option.value,
            $string: (_) => throw StateError('unexpected option type'),
          ),
        );
  }
}
