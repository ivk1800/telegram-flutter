import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SenderTitleFactory {
  Widget? createFromMessageModel(
    BuildContext context,
    BaseConversationMessageTileModel messageModel,
  ) {
    final String? senderName = messageModel.senderName;
    if (senderName == null) {
      return null;
    }

    final ThemeData theme = Theme.of(context);
    final ChatContextData chatContext = ChatContext.of(context);

    return Padding(
      padding: EdgeInsets.only(
        top: chatContext.verticalPadding,
        right: chatContext.horizontalPadding,
        bottom: chatContext.verticalPadding,
        left: chatContext.horizontalPadding,
      ),
      child: Text(
        senderName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.button!.copyWith(color: theme.primaryColor),
      ),
    );
  }
}
