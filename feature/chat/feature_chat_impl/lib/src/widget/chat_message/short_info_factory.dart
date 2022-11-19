import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:chat_theme/chat_theme.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tg_theme/tg_theme.dart';

class ShortInfoFactory {
  const ShortInfoFactory({
    required IStringsProvider stringsProvider,
  }) : _stringsProvider = stringsProvider;

  final IStringsProvider _stringsProvider;

  Widget create({
    required BuildContext context,
    required AdditionalInfo additionalInfo,
    required bool isOutgoing,
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return Padding(
      padding: padding,
      child: _createBase(context, additionalInfo, isOutgoing),
    );
  }

  Widget _createBase(
    BuildContext context,
    AdditionalInfo additionalInfo,
    bool isOutgoing,
  ) {
    final TgThemeData theme = TgTheme.of(context);
    final ChatThemeData chatThemeData = theme.themeOf();
    final TextStyle caption =
        Theme.of(context).extension<TgTextTheme>()!.caption.copyWith(
              color: isOutgoing
                  ? chatThemeData.bubbleShortInfoOutgoingColor
                  : chatThemeData.bubbleShortInfoIncomingColor,
            );
    final double iconSize = caption.fontSize! * 1.4;
    return RichText(
      text: TextSpan(
        style: caption,
        children: <InlineSpan>[
          if (additionalInfo.viewCount != null)
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  baseline: TextBaseline.ideographic,
                  child: Icon(
                    Icons.remove_red_eye,
                    color: caption.color,
                    size: iconSize,
                  ),
                ),
                // todo double tab?
                TextSpan(text: ' ${additionalInfo.viewCount}\u0009\u0009'),
              ],
            ),
          if (additionalInfo.authorSignature != null)
            TextSpan(text: '${additionalInfo.authorSignature}, '),
          if (additionalInfo.isEdited)
            TextSpan(
              text: '${_stringsProvider.editedMessage} ',
            ),
          TextSpan(text: additionalInfo.sentDate),
          if (additionalInfo.hasBeenRead != null)
            WidgetSpan(
              child: Icon(
                additionalInfo.hasBeenRead! ? Icons.done_all : Icons.done,
                color: caption.color,
                size: iconSize,
              ),
            ),
        ],
      ),
    );
  }
}
