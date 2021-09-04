import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

class ShortInfoFactory {
  const ShortInfoFactory({
    required ILocalizationManager localizationManager,
  }) : _localizationManager = localizationManager;

  final ILocalizationManager _localizationManager;

  Widget create(BuildContext context, AdditionalInfo additionalInfo) {
    return _createBase(context, additionalInfo);
  }

  Widget _createBase(BuildContext context, AdditionalInfo additionalInfo) {
    final ThemeData theme = Theme.of(context);

    // todo extract sizes to theme
    final TextStyle caption = theme.textTheme.caption!.copyWith(fontSize: 12);
    final double iconSize = caption.fontSize! * 1.4;
    return RichText(
      text: TextSpan(
        style: caption,
        children: <InlineSpan>[
          if (additionalInfo.viewCount != null)
            TextSpan(children: <InlineSpan>[
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
            ]),
          if (additionalInfo.authorSignature != null)
            TextSpan(text: '${additionalInfo.authorSignature}, '),
          if (additionalInfo.isEdited)
            TextSpan(
              text: '${_localizationManager.getString('EditedMessage')} ',
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
