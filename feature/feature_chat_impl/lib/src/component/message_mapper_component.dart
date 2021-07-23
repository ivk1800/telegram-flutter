import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/mapper/message_reply_info_mapper.dart';
import 'package:feature_chat_impl/src/resolver/formatted_text_resolver.dart';
import 'package:feature_chat_impl/src/resolver/sender_name_resolver.dart';
import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:localization_api/localization_api.dart';

class MessageMapperDependencies {
  const MessageMapperDependencies({
    required this.fileRepository,
    required this.chatRepository,
    required this.userRepository,
    required this.chatMessageRepository,
    required this.messagePreviewResolver,
    required this.localizationManager,
  });

  final ILocalizationManager localizationManager;
  final IFileRepository fileRepository;
  final IChatRepository chatRepository;
  final IUserRepository userRepository;
  final IChatMessageRepository chatMessageRepository;
  final IMessagePreviewResolver messagePreviewResolver;
}

class MessageMapperComponent {
  MessageMapperComponent({required MessageMapperDependencies dependencies})
      : _dependencies = dependencies;

  final MessageMapperDependencies _dependencies;

  MessageTileMapper create() {
    final MessageReplyInfoMapper messageReplyInfoMapper =
        MessageReplyInfoMapper(
      messagePreviewResolver: _dependencies.messagePreviewResolver,
      chatRepository: _dependencies.chatRepository,
      userRepository: _dependencies.userRepository,
      messageRepository: _dependencies.chatMessageRepository,
    );

    return MessageTileMapper(
        senderNameResolver: SenderNameResolver(
          chatRepository: _dependencies.chatRepository,
          userRepository: _dependencies.userRepository,
        ),
        messageReplyInfoMapper: messageReplyInfoMapper,
        userRepository: _dependencies.userRepository,
        dateParser: DateParser(),
        localizationManager: _dependencies.localizationManager,
        formattedTextResolver: FormattedTextResolver());
  }
}
