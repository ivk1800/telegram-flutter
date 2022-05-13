import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

import 'chat/unread_messages_count.dart';
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

class _Cell extends StatelessWidget {
  const _Cell({
    required this.model,
  });

  final ChatTileModel model;

  @override
  Widget build(BuildContext context) {
    final AvatarWidgetFactory avatarWidgetFactory =
        context.read<AvatarWidgetFactory>();
    return Column(
      children: <Widget>[
        SizedBox(
          height: 78,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: avatarWidgetFactory.create(
                  context,
                  chatId: model.id,
                  imageId: model.photoId,
                  radius: 28,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      _FirstRow(
                        model: model,
                      ),
                      const SizedBox(height: 2),
                      _SecondRow(model: model),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.model,
  });

  final ChatTileModel model;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[
      if (model.isSecret) ...<Widget>[
        SvgPicture.asset(
          'assets/icon/secret.svg',
          package: 'coreui',
        ),
        const SizedBox(width: 4),
      ],
      Flexible(
        child: Text(
          model.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          // todo font height, need refactor
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: _kFontHeight,
          ),
        ),
      ),
      if (model.isVerified) ...<Widget>[
        const SizedBox(width: 2),
        SvgPicture.asset(
          'assets/icon/verified.svg',
          package: 'coreui',
        ),
      ],
      if (!model.isVerified && model.isMuted) ...<Widget>[
        const SizedBox(width: 6),
        SvgPicture.asset(
          'assets/icon/muted.svg',
          package: 'coreui',
          color: Colors.grey,
        ),
      ],
      // const Icon(Icons.volume_off, color: Colors.grey, size: 15),
    ];

    return Flexible(child: Row(children: widgets));
  }
}

class _SecondRow extends StatelessWidget {
  const _SecondRow({
    required this.model,
  });

  final ChatTileModel model;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[];
    final List<Widget> subtitleWidgets = <Widget>[];

    final Widget? firstSubtitle =
        model.firstSubtitle == null ? null : _FirstSubtitle(model: model);
    final Widget? secondSubtitle =
        model.secondSubtitle == null ? null : _SecondSubtitle(model: model);

    if (firstSubtitle != null) {
      subtitleWidgets.add(firstSubtitle);
    }

    if (secondSubtitle != null) {
      subtitleWidgets.add(secondSubtitle);
    }

    widgets.add(
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: subtitleWidgets,
        ),
      ),
    );
    if (model.isPinned &&
        model.unreadMessagesCount == 0 &&
        !model.isMentioned) {
      widgets.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            'assets/icon/pinned.svg',
            package: 'coreui',
            width: 23,
            height: 23,
            color: Colors.grey,
          ),
        ),
      );
    }

    // todo extract colors to theme
    if (model.isMentioned) {
      widgets.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(45),
            ),
            child: SvgPicture.asset(
              'assets/icon/mention.svg',
              package: 'coreui',
              width: 23,
              height: 23,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    if ((model.unreadMessagesCount > 1 && model.isMentioned) ||
        (!model.isMentioned && model.unreadMessagesCount > 0)) {
      if (model.isMentioned) {
        widgets.add(const SizedBox(width: 4));
      }
      widgets.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: UnreadMessagesCount(
            count: model.unreadMessagesCount,
            isMuted: model.isMuted,
          ),
        ),
      );
    }

    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}

class _FirstSubtitle extends StatelessWidget {
  const _FirstSubtitle({
    required this.model,
  });

  final ChatTileModel model;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Text(
        model.firstSubtitle!,
        maxLines: model.secondSubtitle != null ? 1 : 2,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.subtitle1!.copyWith(
          height: _kFontHeight,
          color: theme.primaryColor,
        ),
      ),
    );
  }
}

class _SecondSubtitle extends StatelessWidget {
  const _SecondSubtitle({
    required this.model,
  });

  final ChatTileModel model;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Text(
        model.secondSubtitle!,
        maxLines: model.firstSubtitle != null ? 1 : 2,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.subtitle1!.copyWith(
          height: _kFontHeight,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class _FirstRow extends StatelessWidget {
  const _FirstRow({
    required this.model,
  });

  final ChatTileModel model;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final bool? isRead = model.isRead;
    final List<Widget> widgets = <Widget>[
      _Title(model: model),
      if (isRead != null) ...<Widget>[
        SvgPicture.asset(
          'assets/icon/${isRead ? 'double_check' : 'check'}.svg',
          package: 'coreui',
          color: Colors.green,
        ),
        const SizedBox(width: 4),
      ],
      Text(
        model.lastMessageDate ?? '',
        style: theme.textTheme.caption!.copyWith(
          fontSize: 13,
        ),
      ),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }
}

const double _kFontHeight = 1.1;
