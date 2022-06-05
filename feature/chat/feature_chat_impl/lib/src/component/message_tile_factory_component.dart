import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/tile/message_bloc_provider.dart';
import 'package:feature_chat_impl/src/widget/chat_message/chat_message.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/factory/messages_tile_factory_factory.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:lottie_utils/lottie_utils.dart';
import 'package:sticker_navigation_api/sticker_navigation_api.dart';
import 'package:tile/tile.dart';

import 'message_tile_factory_dependencies.dmg.dart';

@j.Component(
  modules: <Type>[
    MessageTileFactoryModule,
    MessageTileFactoryDependenciesModule,
  ],
)
abstract class IMessageTileFactoryComponent {
  TileFactory getTileFactory();
}

@j.module
abstract class MessageTileFactoryModule {
  @j.provides
  @j.singleton
  static MessagesTileFactoryFactory provideMessagesTileFactoryFactory() =>
      MessagesTileFactoryFactory();

  @j.provides
  @j.singleton
  static ShortInfoFactory provideShortInfoFactory(
    IStringsProvider stringsProvider,
  ) =>
      ShortInfoFactory(stringsProvider: stringsProvider);

  @j.provides
  @j.singleton
  static ReplyInfoFactory provideReplyInfoFactory() => const ReplyInfoFactory();

  @j.provides
  @j.singleton
  static SenderTitleFactory provideSenderTitleFactory() =>
      const SenderTitleFactory();

  @j.provides
  @j.singleton
  static ChatMessageFactory provideChatMessageFactory() =>
      const ChatMessageFactory();

  @j.provides
  @j.singleton
  static SenderAvatarFactory provideSenderAvatarFactory(
    tg.AvatarWidgetFactory avatarWidgetFactory,
  ) =>
      SenderAvatarFactory(avatarWidgetFactory: avatarWidgetFactory);

  @j.provides
  @j.singleton
  static MessageComponentResolver provideMessageComponentResolver(
    tg.AvatarWidgetFactory avatarWidgetFactory,
    SenderAvatarFactory senderAvatarFactory,
    IMessageWallContext messageWallContext,
    SenderTitleFactory senderTitleFactory,
    IMessageActionListener messageActionListener,
  ) =>
      MessageComponentResolver(
        senderAvatarFactory: senderAvatarFactory,
        messageWallContext: messageWallContext,
        senderTitleFactory: senderTitleFactory,
        messageActionListener: messageActionListener,
      );

  @j.provides
  @j.singleton
  static tg.AvatarWidgetFactory provideAvatarWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      tg.AvatarWidgetFactory(fileDownloader: fileDownloader);

  @j.provides
  @j.singleton
  static tg.ImageWidgetFactory provideImageWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      tg.ImageWidgetFactory(fileDownloader: fileDownloader);

  @j.provides
  @j.singleton
  static TileFactory provideTileFactory(
    MessagesTileFactoryFactory factory,
    tg.ImageWidgetFactory imageWidgetFactory,
    IMessageWallContext messageWallContext,
    SenderTitleFactory senderTitleFactory,
    ReplyInfoFactory replyInfoFactory,
    ShortInfoFactory shortInfoFactory,
    IStringsProvider stringsProvider,
    ChatMessageFactory chatMessageFactory,
    MessageComponentResolver messageComponentResolver,
    SenderAvatarFactory senderAvatarFactory,
    MessageBlocProvider messageBlocProvider,
  ) =>
      factory.create(
        imageWidgetFactory: imageWidgetFactory,
        messageBlocProvider: messageBlocProvider,
        messageComponentResolver: messageComponentResolver,
        senderAvatarFactory: senderAvatarFactory,
        messageWallContext: messageWallContext,
        senderTitleFactory: senderTitleFactory,
        replyInfoFactory: replyInfoFactory,
        shortInfoFactory: shortInfoFactory,
        stringsProvider: stringsProvider,
        chatMessageFactory: chatMessageFactory,
      );

  @j.singleton
  @j.binds
  IStickersSetScreenRouter bindStickersSetScreenRouter(
    IChatScreenRouter router,
  );

  // todo temporary
  @j.provides
  @j.singleton
  static LottieStickerFileResolver provideLottieStickerFileResolver() =>
      const LottieStickerFileResolver();
}

@j.componentBuilder
abstract class IMessageTileFactoryComponentBuilder {
  IMessageTileFactoryComponentBuilder dependencies(
    MessageTileFactoryDependencies dependencies,
  );

  IMessageTileFactoryComponent build();
}
