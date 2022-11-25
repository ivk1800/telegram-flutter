import 'package:core_presentation/core_presentation.dart';
import 'package:core_utils/core_utils.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:fake/fake.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'showcase_chat_type.dart';

class ChatScreenShowcaseFactory {
  @j.inject
  ChatScreenShowcaseFactory({
    required IStringsProvider stringsProvider,
  }) : _stringsProvider = stringsProvider;

  final IStringsProvider _stringsProvider;

  Widget create(BuildContext context, ShowcaseChatType type) {
    final ChatFeatureDependencies dependencies = ChatFeatureDependencies(
      stringsProvider: _stringsProvider,
      fileDownloader: const FakeFileDownloader(),
      chatBackgroundManager: const FakeChatBackgroundManager(),
      stickerRepository: const FakeStickerRepository(),
      dateParser: const DateParser(),
      functionExecutor: const FakeTdFunctionExecutor(),
      optionsManager: const FakeOptionsManager(
        functionExecutor: FakeTdFunctionExecutor(),
      ),
      basicGroupRepository: const FakeBasicGroupRepository(),
      chatRepository: const FakeChatRepository(),
      fileRepository: const FakeFileRepository(),
      superGroupRepository: const FakeSuperGroupRepository(),
      userRepository: FakeUserRepository(),
      superGroupUpdatesProvider: const FakeSuperGroupUpdatesProvider(),
      basicGroupUpdatesProvider: const FakeBasicGroupUpdatesProvider(),
      chatMessagesUpdatesProvider: const FakeChatMessagesUpdatesProvider(),
      chatMessageRepository: const FakeChatMessageRepository(),
      chatUpdatesProvider: const FakeChatUpdatesProvider(),
      chatManager: const FakeChatManager(),
      errorTransformer: const FakeErrorTransformer(),
      routerFactory: const _RouteFactory(),
      messagePreviewResolver: const FakeMessagePreviewResolver(),
      chatHeaderInfoFeatureApi: const _ChatHeaderInfoFeatureApi(),
    );

    final ChatFeature feature = ChatFeature(
      dependencies: dependencies,
    );
    return feature.chatScreenFactory.create(0);
  }
}

class _Router implements IChatScreenRouter {
  const _Router();

  @override
  void toChat(int chatId) {}

  @override
  void close() {}

  @override
  void toChatProfile({required int chatId, required ProfileType type}) {}

  @override
  void toDialog({
    String? title,
    required Body body,
    List<Action> actions = const <Action>[],
  }) {}

  @override
  void toStickersSet(int setId) {}
}

class _RouteFactory implements IChatScreenRouterFactory {
  const _RouteFactory();

  @override
  IChatScreenRouter create(int chatId) {
    return const _Router();
  }
}

class _ChatHeaderInfoFeatureApi implements IChatHeaderInfoFeatureApi {
  const _ChatHeaderInfoFeatureApi();

  @override
  IChatHeaderInfoFactory getChatHeaderInfoFactory() {
    return const _ChatHeaderInfoFactory();
  }

  @override
  IChatHeaderInfoInteractor getChatHeaderInfoInteractor(int chatId) {
    return _ChatHeaderInfoInteractor();
  }
}

class _ChatHeaderInfoFactory implements IChatHeaderInfoFactory {
  const _ChatHeaderInfoFactory();

  @override
  Widget create({
    required BuildContext context,
    required ChatHeaderInfo info,
    void Function()? onProfileTap,
  }) {
    return Container();
  }
}

class _ChatHeaderInfoInteractor implements IChatHeaderInfoInteractor {
  @override
  ChatHeaderInfo get current => ChatHeaderInfo(
        title: '',
        subtitle: '',
        avatar: const Avatar.savedMessages(),
      );

  @override
  Stream<ChatHeaderInfo> get infoStream => const Stream<ChatHeaderInfo>.empty();
}
