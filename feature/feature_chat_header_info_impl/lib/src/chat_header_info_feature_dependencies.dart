import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';

class ChatHeaderInfoFeatureDependencies {
  const ChatHeaderInfoFeatureDependencies({
    required this.chatRepository,
    required this.localizationManager,
    required this.basicGroupRepository,
    required this.superGroupRepository,
    required this.userRepository,
    required this.fileRepository,
    required this.connectionStateProvider,
  });

  final IChatRepository chatRepository;

  final IUserRepository userRepository;

  final IFileRepository fileRepository;

  final IConnectionStateProvider connectionStateProvider;

  final ILocalizationManager localizationManager;

  final IBasicGroupRepository basicGroupRepository;

  final ISuperGroupRepository superGroupRepository;
}
