import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/model/model.dart';
import 'package:presentation/src/widget/widget.dart';
import 'package:jugger/jugger.dart' as j;

typedef ChatTapCallback = void Function(int id);

class ChatTileFactory {
  @j.inject
  ChatTileFactory(this._avatarWidgetFactory);

  final AvatarWidgetFactory _avatarWidgetFactory;

  Widget create(
      BuildContext context, ChatTileModel chat, ChatTapCallback onTap) {
    return InkWell(
      onTap: () => onTap.call(chat.id),
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _avatarWidgetFactory.create(context, chat.photoId),
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
    );
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
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 19),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(chat.lastMessageDate ?? '',
            style:
                Theme.of(context).textTheme.headline6!.copyWith(fontSize: 17))
      ],
    );
  }

  Widget _buildSecondLine(BuildContext context, ChatTileModel chat) {
    return Text.rich(chat.subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 19));
  }
}
