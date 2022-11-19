import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:tg_theme/tg_theme.dart';

class SenderTitleFactory {
  const SenderTitleFactory();

  Widget createFromMessageModel(
    BuildContext context,
    BaseConversationMessageTileModel messageModel,
  ) {
    final String senderName = messageModel.senderInfo.senderName;

    final TgTextTheme textTheme = Theme.of(context).extension<TgTextTheme>()!;
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
        style: textTheme.subtitle3.copyWith(
          // todo extract ext
          color: AvatarWidgetFactory.colors[
              (messageModel.senderInfo.id % AvatarWidgetFactory.colors.length)
                  .abs()],
        ),
      ),
    );
  }
}
