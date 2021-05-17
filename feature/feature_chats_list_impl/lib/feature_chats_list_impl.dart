library feature_chats_list_impl;

import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_chats_list_impl/src/screen/chats_list_page.dart';
import 'package:flutter/widgets.dart';
import 'src/di/chats_list_screen_component.dart';

class ChatsListFeatureApi implements IChatsListFeatureApi {
  ChatsListFeatureApi({required this.dependencies})
      : _chatsListWidgetFactory =
            _ChatsListWidgetFactory(dependencies: dependencies);

  final IChatsListWidgetFactory _chatsListWidgetFactory;

  final IChatsListFeatureDependencies dependencies;

  @override
  IChatsListWidgetFactory get screenWidgetFactory => _chatsListWidgetFactory;
}

abstract class IChatsListFeatureDependencies {}

// class ChatsListFeatureDependencies implements IChatsListFeatureDependencies {
//
// }

class _ChatsListWidgetFactory implements IChatsListWidgetFactory {
  _ChatsListWidgetFactory({required this.dependencies});

  final IChatsListFeatureDependencies dependencies;

  @override
  Widget create() => const ChatsListPage().wrap(dependencies);
}
