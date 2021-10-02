import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/src/tile/model/base_conversation_message_tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SenderAvatarFactory {
  const SenderAvatarFactory({
    required AvatarWidgetFactory avatarWidgetFactory,
  }) : _avatarWidgetFactory = avatarWidgetFactory;

  final AvatarWidgetFactory _avatarWidgetFactory;

  Widget create({
    required BuildContext context,
    required SenderInfo senderInfo,
    required GestureTapCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: _avatarWidgetFactory.create(
            context,
            chatId: senderInfo.id,
            imageId: senderInfo.senderPhotoId,
          ),
        ),
      ),
    );
  }
}
