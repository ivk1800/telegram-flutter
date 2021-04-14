import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/model/model.dart';
import 'package:presentation/src/widget/widget.dart';
import 'package:jugger/jugger.dart' as j;

abstract class ChatTileListener {
  void onChatTap(int id);

  void onTogglePinTap(int id);
}

class ChatTileFactory {
  @j.inject
  ChatTileFactory(this._avatarWidgetFactory, this._listener);

  final AvatarWidgetFactory _avatarWidgetFactory;
  final ChatTileListener _listener;

  Widget create(BuildContext context, ChatTileModel chat) {
    return InkWell(
      onLongPress: () => _showContextAlertDialog(context: context, chat: chat),
      key: ObjectKey(chat.id),
      onTap: () => _listener.onChatTap(chat.id),
      child: Container(
        color: chat.isPinned ? Colors.grey : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _avatarWidgetFactory.create(context,
                  chatId: chat.id, imageId: chat.photoId, radius: 27),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildFirstLine(context, chat),
                    const SizedBox(
                      height: 4,
                    ),
                    _buildSecondLine(context, chat)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showContextAlertDialog(
      {required BuildContext context, required ChatTileModel chat}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          _buildContextAlertDialog(context: context, chat: chat),
    );
  }

  Widget _buildContextAlertDialog(
      {required BuildContext context, required ChatTileModel chat}) {
    return AlertDialog(
        content: SingleChildScrollView(
      child: ListTile(
        title: Text(chat.isPinned ? 'unpin' : 'pin'),
        onTap: () {
          Navigator.of(context).pop();
          _listener.onTogglePinTap(chat.id);
        },
      ),
    ));
  }

  Widget _buildFirstLine(BuildContext context, ChatTileModel chat) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            chat.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 16),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(chat.lastMessageDate ?? '',
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14))
      ],
    );
  }

  Widget _buildSecondLine(BuildContext context, ChatTileModel chat) {
    return Text.rich(chat.subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16));
  }
}
