import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
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
// import 'showcase_message_page.dart';

@j.Component(
  modules: <Type>[MessageShowcaseModule],
)
abstract class IMessageShowcaseComponent {
  ILocalizationManager getLocalizationManager();

  MessageShowcaseViewModel getMessageShowcaseViewModel();

  TileFactory getTileFactory();
}

@j.module
abstract class MessageShowcaseModule {
  @j.provides
  @j.singleton
  static TileFactory provideTileFactory(
    IFileDownloader fileDownloader,
    IMessageWallContext messageWallContext,
    IMessageActionListener messageActionListener,
    IFileRepository fileRepository,
    ILocalizationManager localizationManager,
  ) =>
      MessageTileFactoryComponent(
        dependencies: MessageTileFactoryDependencies(
          fileDownloader: fileDownloader,
          messageWallContext: messageWallContext,
          messageActionListener: messageActionListener,
          fileRepository: fileRepository,
          localizationManager: localizationManager,
        ),
      ).create();

  @j.provides
  @j.singleton
  static MessageShowcaseViewModel provideMessageShowcaseViewModel(
    MessageBundle messageBundle,
    MessageTileMapper messageTileMapper,
  ) =>
      MessageShowcaseViewModel(
        messageTileMapper: messageTileMapper,
        messageBundle: messageBundle,
      )..init();

  @j.provides
  @j.singleton
  static IFileDownloader provideFileDownloader() => fake.FakeFileDownloader();

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
    ILocalizationManager localizationManager,
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
          localizationManager: localizationManager,
        ),
      ).create();

  @j.provides
  @j.singleton
  static IMessagePreviewResolver provideMessagePreviewResolver(
    IUserRepository userRepository,
    IChatRepository chatRepository,
    ILocalizationManager localizationManager,
    IChatMessageRepository chatMessageRepository,
  ) {
    return MessagePreviewResolver(
      userRepository: userRepository,
      chatRepository: chatRepository,
      localizationManager: localizationManager,
      mode: Mode.replyPreview,
      messageRepository: chatMessageRepository,
    );
  }
}

@j.componentBuilder
abstract class IMessageShowcaseComponentBuilder {
  IMessageShowcaseComponentBuilder localizationManager(
    ILocalizationManager value,
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
  bool isDisplayAvatarFor(int messageId) => false;

  @override
  bool isDisplaySenderNameFor(int messageId) => false;
}
