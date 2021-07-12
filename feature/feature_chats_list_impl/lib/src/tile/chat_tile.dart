import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_tile_model.dart';

abstract class ChatTileListener {
  void onChatTap(int id);

  void onTogglePinTap(int id);
}

class ChatTileFactory {
  @j.inject
  ChatTileFactory(
      {required AvatarWidgetFactory avatarWidgetFactory,
      required ChatTileListener listener})
      : _avatarWidgetFactory = avatarWidgetFactory,
        _listener = listener;

  final AvatarWidgetFactory _avatarWidgetFactory;
  final ChatTileListener _listener;

  Widget create(BuildContext context, ChatTileModel chat) {
    return _create(context, chat);
  }

  // TODO: fix overflow for subtitle with emoji
  Widget _create(BuildContext context, ChatTileModel model) {
    return InkWell(
      onLongPress: () => _showContextAlertDialog(context: context, chat: model),
      key: ObjectKey(model.id),
      onTap: () => _listener.onChatTap(model.id),
      child: Ink(
        color: model.isPinned ? Colors.grey[200] : null,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 75,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
                    child: _avatarWidgetFactory.create(context,
                        chatId: model.id, imageId: model.photoId, radius: 27),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          _buildFirstRow(context, model),
                          Flexible(
                            child: _buildSecondRow(context, model),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFirstRow(BuildContext context, ChatTileModel model) {
    final ThemeData theme = Theme.of(context);

    final List<Widget> widgets = <Widget>[];
    widgets.add(
      Flexible(
        child: _buildTitle(context, model),
      ),
    );
    widgets.add(Text(model.lastMessageDate ?? '',
        style: theme.textTheme.caption!.copyWith(fontSize: 14)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: widgets,
    );
  }

  Widget _buildTitle(BuildContext context, ChatTileModel model) {
    final List<Widget> widgets = <Widget>[
      Flexible(
        child: Text(model.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            // todo font height, need refactor
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: kFontHeight)),
      ),
    ];

    if (model.isVerified) {
      widgets.add(
        const Icon(Icons.star_sharp, color: Colors.green, size: 15),
      );
    }

    if (model.isMuted) {
      widgets.add(const Icon(Icons.volume_off, color: Colors.grey, size: 15));
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: widgets,
    );
  }

  Widget _buildSecondRow(BuildContext context, ChatTileModel model) {
    final List<Widget> widgets = <Widget>[];
    final List<Widget> subtitleWidgets = <Widget>[];

    final Widget? firstSubtitle = _createFirstSubtitle(context, model);
    final Widget? secondSubtitle = _createSecondSubtitle(context, model);

    if (firstSubtitle != null) {
      subtitleWidgets.add(firstSubtitle);
    }

    if (secondSubtitle != null) {
      subtitleWidgets.add(secondSubtitle);
    }

    widgets.add(Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subtitleWidgets,
      ),
    ));
    if (model.isPinned &&
        model.unreadMessagesCount == 0 &&
        !model.isMentioned) {
      widgets.add(const Align(
          alignment: Alignment.bottomCenter,
          child: Icon(Icons.push_pin_rounded, size: 18, color: Colors.grey)));
    }

    // todo extract colors to theme
    if (model.isMentioned) {
      widgets.add(Align(
          alignment: Alignment.bottomCenter,
          child: _buildCircle(
              context: context, text: '@', color: Colors.lightGreen)));
    }

    if ((model.unreadMessagesCount > 1 && model.isMentioned) ||
        (!model.isMentioned && model.unreadMessagesCount > 0)) {
      if (model.isMentioned) {
        widgets.add(const SizedBox(
          width: 4,
        ));
      }
      widgets.add(Align(
          alignment: Alignment.bottomCenter,
          child: _buildCircle(
              context: context,
              text: '${model.unreadMessagesCount}',
              color: model.isMuted ? Colors.blueGrey : Colors.lightGreen)));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: widgets,
    );
  }

  // todo need improvements, fix horizontal padding, text align
  Widget _buildCircle(
      {required BuildContext context,
      required String text,
      required Color color}) {
    return Container(
      constraints: const BoxConstraints(minWidth: 20, maxHeight: 20),
      child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 3, right: 4),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  // todo magic number height, need refactor
                  .copyWith(height: 1.05, color: Colors.white),
              // style: TextStyle(height: 1.025, color: Colors.white),
            ),
          )),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget? _createFirstSubtitle(BuildContext context, ChatTileModel model) {
    final ThemeData theme = Theme.of(context);

    if (model.firstSubtitle == null) {
      return null;
    }

    return Expanded(
        child: Text(
      model.firstSubtitle!,
      maxLines: model.secondSubtitle != null ? 1 : 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.subtitle1!
          .copyWith(height: kFontHeight, color: theme.primaryColor),
    ));
  }

  Widget? _createSecondSubtitle(BuildContext context, ChatTileModel model) {
    final ThemeData theme = Theme.of(context);

    if (model.secondSubtitle == null) {
      return null;
    }

    return Expanded(
        child: Text(
      model.secondSubtitle!,
      maxLines: model.firstSubtitle != null ? 1 : 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.subtitle1!
          .copyWith(height: kFontHeight, color: Colors.grey[600]),
    ));
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

  static const double kFontHeight = 1.2;
}
