import 'package:chat_list_theme/chat_list_theme.dart';
import 'package:chat_list_ui_kit/chat_list_ui_kit.dart';
import 'package:core_presentation/core_presentation.dart';
import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

import 'chat_tile_model.dart';

abstract class IChatTileListener {
  void onChatTap(int id);

  void onTogglePinTap(int id);
}

class ChatTileFactory implements ITileFactoryDelegate<ChatTileModel> {
  ChatTileFactory({
    required AvatarWidgetFactory avatarWidgetFactory,
    required IChatTileListener listener,
  })  : _avatarWidgetFactory = avatarWidgetFactory,
        _listener = listener;

  final AvatarWidgetFactory _avatarWidgetFactory;
  final IChatTileListener _listener;

  // TODO: fix overflow for subtitle with emoji
  // TODO: support dark theme
  // TODO: extract text styles to theme
  @override
  Widget create(BuildContext context, ChatTileModel chat) {
    return Provider<AvatarWidgetFactory>.value(
      value: _avatarWidgetFactory,
      child: InkWell(
        onLongPress: () =>
            _showContextAlertDialog(context: context, chat: chat),
        key: ObjectKey(chat.id),
        onTap: () => _listener.onChatTap(chat.id),
        child: Ink(
          color: chat.isPinned ? Colors.grey[200] : null,
          child: _Cell(
            model: chat,
          ),
        ),
      ),
    );
  }

  void _showContextAlertDialog({
    required BuildContext context,
    required ChatTileModel chat,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListTile(
              title: Text(chat.isPinned ? 'unpin' : 'pin'),
              onTap: () {
                Navigator.of(context).pop();
                _listener.onTogglePinTap(chat.id);
              },
            ),
          ),
        );
      },
    );
  }
}

class _LeadingAvatar extends StatelessWidget {
  const _LeadingAvatar({
    required this.avatar,
    required this.isForum,
  });

  final Avatar avatar;
  final bool isForum;

  @override
  Widget build(BuildContext context) {
    final AvatarWidgetFactory avatarWidgetFactory =
        context.read<AvatarWidgetFactory>();

    return avatarWidgetFactory.create(
      context,
      avatar: avatar,
      radius: 28,
      borderRadius: BorderRadius.all(
        Radius.circular(
          isForum ? 20 : AvatarWidgetFactory.kDefaultBorderRadius,
        ),
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.model,
  });

  final ChatTileModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ChatHeightProvider.getValue(context),
      child: Row(
        children: <Widget>[
          const SizedBox(width: ChatCellTheme.kHorizontalSpace),
          _LeadingAvatar(
            avatar: model.avatar,
            isForum: model.isForum,
          ),
          const SizedBox(width: ChatCellTheme.kHorizontalSpace),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: ChatCellTheme.kVerticalSpace,
              ),
              child: ChatCellBody(
                unreadMessagesCount: model.unreadMessagesCount,
                isPinned: model.isPinned,
                isMentioned: model.isMentioned,
                secondSubtitle: model.secondSubtitle,
                firstSubtitle: model.firstSubtitle,
                lastMessageDate: model.lastMessageDate,
                isRead: model.isRead,
                isVerified: model.isVerified,
                isSecret: model.isSecret,
                isMuted: model.isMuted,
                title: model.title,
              ),
            ),
          ),
          const SizedBox(width: ChatCellTheme.kHorizontalSpace),
        ],
      ),
    );
  }
}
