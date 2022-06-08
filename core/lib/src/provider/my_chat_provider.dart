import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

// TODO move to core-td module
class MyChatProvider {
  MyChatProvider({
    required OptionsManager optionsManager,
    required ITdFunctionExecutor functionExecutor,
  })  : _functionExecutor = functionExecutor,
        _optionsManager = optionsManager;

  final OptionsManager _optionsManager;
  final ITdFunctionExecutor _functionExecutor;

  // TODO handle potential errors
  // TODO extract myChatResolver and to place in core module
  late final Future<int> _myChatIdFuture =
      _optionsManager.getMyId().then((int myId) {
    return _functionExecutor.send<td.Chat>(
      td.CreatePrivateChat(userId: myId, force: false),
    );
  }).then((td.Chat myChat) => myChat.id);

  Future<int> get myChatId => _myChatIdFuture;
}
