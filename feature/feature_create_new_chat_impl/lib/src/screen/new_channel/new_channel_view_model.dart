import 'package:async/async.dart';
import 'package:async_utils/async_utils.dart';
import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart' as d;
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'new_channel_screen_router.dart';

@screenScope
class NewChannelViewModel extends BaseViewModel {
  @j.inject
  NewChannelViewModel({
    required IChatManager chatManager,
    required IBlockInteractionManager blockInteractionManager,
    required INewChannelScreenRouter router,
    required IStringsProvider stringsProvider,
    required IErrorTransformer errorTransformer,
  })  : _chatManager = chatManager,
        _router = router,
        _stringsProvider = stringsProvider,
        _errorTransformer = errorTransformer,
        _blockInteractionManager = blockInteractionManager;

  final IChatManager _chatManager;
  final IBlockInteractionManager _blockInteractionManager;
  final INewChannelScreenRouter _router;
  final IErrorTransformer _errorTransformer;
  final IStringsProvider _stringsProvider;

  void onCreateChannelTap({
    required String name,
    required String description,
  }) {
    if (name.isEmpty) {
      return;
    }
    createChannel(name: name, description: description);
  }

  void createChannel({
    required String name,
    required String description,
  }) {
    _blockInteractionManager.setState(active: true);
    final CancelableOperation<int> operation = _chatManager
        .createChannel(name: name, description: description)
        .toCancelableOperation()
        .onTerminate(() {
      _blockInteractionManager.setState(active: false);
    }).onError((Object error) {
      _router.toDialog(
        body: d.Body.text(
          text: _errorTransformer.transformToString(error),
        ),
        actions: <d.Action>[
          d.Action(text: _stringsProvider.oK),
        ],
      );
    }).onValue(_router.closeAfterCreateChannel);
    attach(operation);
  }
}
