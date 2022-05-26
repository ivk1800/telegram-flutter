import 'create_new_channel_screen_factory.dart';
import 'create_new_group_screen_factory.dart';
import 'create_new_secret_chat_screen_factory.dart';
import 'new_chat_screen_factory.dart';

abstract class ICreateNewChatFeatureApi {
  INewChatScreenFactory get newChatScreenFactory;

  ICreateNewGroupScreenFactory get createNewGroupScreenFactory;

  ICreateNewSecretChatScreenFactory get createNewSecretChatScreenFactory;

  ICreateNewChannelScreenFactory get createNewChannelScreenFactory;
}
