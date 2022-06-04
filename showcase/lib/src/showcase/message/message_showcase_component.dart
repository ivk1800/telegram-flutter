import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:coreui/coreui.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:fake/fake.dart' as fake;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:feature_message_preview_resolver_impl/feature_message_preview_resolver_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'message_bundle.dart';
import 'message_showcase_view_model.dart';

@j.Component(
  modules: <Type>[MessageShowcaseModule],
)
abstract class IMessageShowcaseComponent {
  MessageShowcaseViewModel getMessageShowcaseViewModel();

  IInteractableMessageFactory getInteractableMessageFactory();
}

@j.module
abstract class MessageShowcaseModule {
  @j.provides
  @j.singleton
  static TileFactory provideTileFactory(
    IFileDownloader fileDownloader,
    IMessageWallContext messageWallContext,
    IMessageActionListener messageActionListener,
    IStringsProvider stringsProvider,
  ) =>
      MessageTileFactory(
        dependencies: MessageTileFactoryDependencies(
          chatScreenRouter: const ChatScreenRouterStub(),
          fileDownloader: fileDownloader,
          messageWallContext: messageWallContext,
          messageActionListener: messageActionListener,
          stringsProvider: stringsProvider,
        ),
      ).create();

  @j.provides
  @j.singleton
  static IInteractableMessageFactory provideInteractableMessageFactory(
    IMessageWallContext messageWallContext,
    IMessageActionListener messageActionListener,
    AvatarWidgetFactory avatarWidgetFactory,
    TileFactory tileFactory,
  ) =>
      InteractableMessageFactoryComponent(
        tileFactory: tileFactory,
        messageActionListener: messageActionListener,
        messageWallContext: messageWallContext,
        avatarWidgetFactory: avatarWidgetFactory,
      ).create();

  @j.provides
  @j.singleton
  static AvatarWidgetFactory provideAvatarWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      AvatarWidgetFactory(fileDownloader: fileDownloader);

  @j.provides
  @j.singleton
  static MessageShowcaseViewModel provideMessageShowcaseViewModel(
    MessageBundle messageBundle,
    MessageTileMapper messageTileMapper,
  ) =>
      MessageShowcaseViewModel(
        messageTileMapper: messageTileMapper,
        messageBundle: messageBundle,
      );

  @j.provides
  @j.singleton
  static IFileDownloader provideFileDownloader() =>
      const fake.FakeFileDownloader();

  @j.provides
  @j.singleton
  static IMessageActionListener provideMessageActionListener() =>
      _MessageActionListenerStub();

  @j.provides
  @j.singleton
  static IMessageWallContext provideMessageWallContext() =>
      _FakeMessageWallContext();

  @j.provides
  @j.singleton
  static IChatMessageRepository provideChatMessageRepository() =>
      fake.FakeChatMessageRepository(
        fakeMessages: <td.Message>[
          fake.createFakeMessage(),
        ],
      );

  @j.provides
  @j.singleton
  static IChatRepository provideChatRepository() => fake.FakeChatRepository();

  @j.provides
  @j.singleton
  static IFileRepository provideFileRepository() =>
      const fake.FakeFileRepository();

  @j.provides
  @j.singleton
  static IUserRepository provideUserRepository() => fake.FakeUserRepository(
        fakeUserProvider: const fake.FakeUserProvider(),
      );

  @j.provides
  @j.singleton
  static MessageTileMapper provideMessageTileMapper(
    IStringsProvider stringsProvider,
    IChatMessageRepository chatMessageRepository,
    IChatRepository chatRepository,
    IUserRepository userRepository,
    IMessagePreviewResolver messagePreviewResolver,
    IFileRepository fileRepository,
  ) =>
      MessageMapperComponent(
        dependencies: MessageMapperDependencies(
          dateParser: DateParser(),
          chatMessageRepository: chatMessageRepository,
          chatRepository: chatRepository,
          userRepository: userRepository,
          messagePreviewResolver: messagePreviewResolver,
          fileRepository: fileRepository,
          stringsProvider: stringsProvider,
        ),
      ).create();

  @j.provides
  @j.singleton
  static IMessagePreviewResolver provideMessagePreviewResolver(
    IUserRepository userRepository,
    IChatRepository chatRepository,
    IStringsProvider stringsProvider,
    IChatMessageRepository chatMessageRepository,
  ) {
    return MessagePreviewResolver(
      userRepository: userRepository,
      chatRepository: chatRepository,
      stringsProvider: stringsProvider,
      mode: Mode.replyPreview,
      messageRepository: chatMessageRepository,
    );
  }
}

@j.componentBuilder
abstract class IMessageShowcaseComponentBuilder {
  IMessageShowcaseComponentBuilder stringsProvider(
    IStringsProvider value,
  );

  IMessageShowcaseComponentBuilder messageBundle(
    MessageBundle value,
  );

  IMessageShowcaseComponent build();
}

class _MessageActionListenerStub implements IMessageActionListener {
  @override
  void onSenderAvatarTap({required int senderId, required SenderType type}) {}
}

class _FakeMessageWallContext implements IMessageWallContext {
  @override
  bool isDisplayAvatarFor(int messageId) => true;

  @override
  bool isDisplaySenderNameFor(int messageId) => false;
}

// todo model to fake module
class ChatScreenRouterStub implements IChatScreenRouter {
  const ChatScreenRouterStub();

  @override
  void close() {}

  @override
  void toChat(int chatId) {}

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
