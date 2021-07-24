import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/tile/model/tile_model.dart';
import 'package:feature_chat_impl/src/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

class MessageContactTileFactoryDelegate
    implements ITileFactoryDelegate<MessageContactTileModel> {
  MessageContactTileFactoryDelegate(
      {required ChatMessageFactory chatMessageFactory,
      required ILocalizationManager localizationManager,
      required SenderTitleFactory senderTitleFactory,
      required ReplyInfoFactory replyInfoFactory,
      required ShortInfoFactory shortInfoFactory})
      : _chatMessageFactory = chatMessageFactory,
        _replyInfoFactory = replyInfoFactory,
        _senderTitleFactory = senderTitleFactory,
        _localizationManager = localizationManager,
        _shortInfoFactory = shortInfoFactory;

  final ChatMessageFactory _chatMessageFactory;
  final ShortInfoFactory _shortInfoFactory;
  final ILocalizationManager _localizationManager;
  final ReplyInfoFactory _replyInfoFactory;
  final SenderTitleFactory _senderTitleFactory;

  @override
  Widget create(BuildContext context, MessageContactTileModel model) {
    final ChatContextData chatContext = ChatContext.of(context);
    // todo specify value from ref(ios, android)
    // todo move to config
    const double maxWidth = 220;
    return _chatMessageFactory.createConversationMessage(
        id: model.id,
        isOutgoing: model.isOutgoing,
        context: context,
        senderTitle: _senderTitleFactory.createFromMessageModel(context, model),
        reply: _replyInfoFactory.createFromMessageModel(context, model),
        blocks: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: chatContext.verticalPadding,
                left: chatContext.horizontalPadding,
                right: chatContext.horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // todo replace ListTile by own layout
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                    // todo display avatar
                    leading: const CircleAvatar(),
                    title: Text(
                      model.title,
                      maxLines: 1,
                    ),
                    subtitle: Text(
                      model.subtitle,
                      maxLines: 1,
                    ),
                    // todo handle tap
                    trailing: const Icon(Icons.more_vert),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(maxWidth, 40),
                      ),
                      onPressed: () {
                        // todo handle tap
                      },
                      child:
                          Text(_localizationManager.getString('ViewContact'))),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4, top: 4),
                      child: _shortInfoFactory.create(
                          context, model.additionalInfo),
                    ),
                  )
                ],
              ),
            ),
          )
        ]);
  }
}
