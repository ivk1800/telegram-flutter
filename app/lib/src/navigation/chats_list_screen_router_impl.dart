import 'package:app/src/feature/feature.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chats_list_impl/feature_chats_list_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:split_view/split_view.dart';

import 'navigation.dart';

class ChatsListScreenRouterImpl implements IChatsListScreenRouter {
  @j.inject
  ChatsListScreenRouterImpl(
    FeatureFactory featureFactory,
    SplitNavigationInfoProvider splitNavigationInfoProvider,
    KeyGenerator keyGenerator,
    SplitNavigationRouter navigationRouter,
  )   : _navigationRouter = navigationRouter,
        _featureFactory = featureFactory,
        _splitNavigationInfoProvider = splitNavigationInfoProvider,
        _keyGenerator = keyGenerator;

  final SplitNavigationInfoProvider _splitNavigationInfoProvider;
  final KeyGenerator _keyGenerator;
  final SplitNavigationRouter _navigationRouter;
  final FeatureFactory _featureFactory;

  // TODO extract chat router delegate
  @override
  void toChat(int chatId) {
    final ValueKey<dynamic> key = _keyGenerator.generateForChat(chatId);

    if (_splitNavigationInfoProvider.hasKey(key, ContainerType.right)) {
      // TODO scroll to last message
    } else {
      final IChatScreenFactory factory =
          _featureFactory.createChatFeatureApi().chatScreenFactory;
      _navigationRouter.pushAllReplacement(
        key: key,
        builder: (BuildContext context) => factory.create(context, chatId),
        container: ContainerType.right,
      );
    }
  }
}
