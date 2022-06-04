import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/resolver/message_component_resolver.dart';
import 'package:feature_chat_impl/src/screen/chat/interactable_message_factory.dart';
import 'package:feature_chat_impl/src/screen/chat/message/popup/message_popup_listener.dart';
import 'package:feature_chat_impl/src/screen/chat/message/popup/message_popup_menu.dart';
import 'package:feature_chat_impl/src/screen/chat/message_factory.dart';
import 'package:feature_chat_impl/src/wall/message_wall_context.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_avatar_factory.dart';
import 'package:feature_chat_impl/src/widget/chat_message/sender_title_factory.dart';
import 'package:tile/tile.dart';

import 'message_action_listener.dart';

class InteractableMessageFactoryComponent {
  InteractableMessageFactoryComponent({
    required TileFactory tileFactory,
    required AvatarWidgetFactory avatarWidgetFactory,
    required IMessageWallContext messageWallContext,
    required IMessageActionListener messageActionListener,
  })  : _tileFactory = tileFactory,
        _avatarWidgetFactory = avatarWidgetFactory,
        _messageActionListener = messageActionListener,
        _messageWallContext = messageWallContext;

  final TileFactory _tileFactory;
  final IMessageActionListener _messageActionListener;
  final AvatarWidgetFactory _avatarWidgetFactory;
  final IMessageWallContext _messageWallContext;

  IInteractableMessageFactory create() {
    final MessageComponentResolver messageComponentResolver =
        MessageComponentResolver(
      senderAvatarFactory: SenderAvatarFactory(
        avatarWidgetFactory: _avatarWidgetFactory,
      ),
      messageWallContext: _messageWallContext,
      senderTitleFactory: const SenderTitleFactory(),
      messageActionListener: _messageActionListener,
    );

    return MessageFactory(
      popupMenuListener: const _MessagePopupMenuListenerStub(),
      tileFactory: _tileFactory,
      messageComponentResolver: messageComponentResolver,
    );
  }
}

class _MessagePopupMenuListenerStub implements IMessagePopupMenuListener {
  const _MessagePopupMenuListenerStub();

  @override
  void onWillShowPopupMenu(int messageId, IMessagePopupMenu popupMenu) {}

  @override
  void onItemSelected(ItemAction item) {}
}
