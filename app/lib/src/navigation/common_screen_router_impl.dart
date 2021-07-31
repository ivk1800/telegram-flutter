import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/feature/feature.dart';
import 'package:split_view/split_view.dart';

import 'navigation.dart';

class CommonScreenRouterImpl
    implements IChatScreenRouter, IProfileFeatureRouter {
  @j.inject
  CommonScreenRouterImpl({
    required SplitNavigationRouter navigationRouter,
    required FeatureFactory featureFactory,
  })  : _navigationRouter = navigationRouter,
        _featureFactory = featureFactory;

  final SplitNavigationRouter _navigationRouter;
  final FeatureFactory _featureFactory;

  @override
  void toChat(int id) {}

  @override
  void toChatProfile(int chatId) {
    final IProfileScreenFactory factory =
        _featureFactory.createProfileFeatureApi().profileScreenFactory;
    _navigationRouter.push(
        key: UniqueKey(),
        builder: (BuildContext context) => factory.create(context, chatId),
        container: ContainerType.Top);
  }

  @override
  void toSharedMedia(SharedContentType type) {
    final ISharedMediaScreenFactory factory =
        _featureFactory.createSharedMediaFeatureApi().sharedMediaScreenFactory;
    _navigationRouter.push(
        key: UniqueKey(),
        builder: (BuildContext context) => factory.create(context, type),
        container: ContainerType.Top);
  }
}
