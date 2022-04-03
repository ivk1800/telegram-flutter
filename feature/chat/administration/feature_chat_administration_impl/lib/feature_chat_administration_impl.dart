library feature_chat_administration_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_administration_api/feature_chat_administration_api.dart';
import 'package:feature_chat_administration_impl/src/screen/chat_administration/chat_administration_screen_router_factory.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/chat_administration/chat_administration_router.dart';
import 'src/screen/chat_administration/chat_administration_screen_factory.dart';

export 'src/screen/chat_administration/chat_administration_router.dart';
export 'src/screen/chat_administration/chat_administration_screen_router_factory.dart';

class ChatAdministrationFeature implements IChatAdministrationFeatureApi {
  ChatAdministrationFeature({
    required ChatAdministrationFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatAdministrationFeatureDependencies _dependencies;
  late final ChatAdministrationScreenFactory _ChatAdministrationScreenFactory =
      ChatAdministrationScreenFactory(dependencies: _dependencies);

  @override
  IChatAdministrationScreenFactory get chatAdministrationScreenFactory =>
      _ChatAdministrationScreenFactory;
}

class ChatAdministrationFeatureDependencies {
  ChatAdministrationFeatureDependencies({
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.routerFactory,
  });

  final IConnectionStateProvider connectionStateProvider;
  final IStringsProvider stringsProvider;
  final IChatAdministrationRouterFactory routerFactory;
}
