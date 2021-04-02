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
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: _avatarWidgetFactory.create(context, chat.photoId),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    chat.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 19),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text.rich(chat.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 19))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
