library feature_create_new_chat_api;

import 'package:flutter/widgets.dart';

abstract class ICreateNewChatFeatureApi {
  INewChatScreenFactory get newChatScreenFactory;

  ICreateNewGroupScreenFactory get createNewGroupScreenFactory;

  ICreateNewSecretChatScreenFactory get createNewSecretChatScreenFactory;

  ICreateNewChannelScreenFactory get createNewChannelScreenFactory;
}

abstract class INewChatScreenFactory {
  Widget create(BuildContext context);
}

abstract class ICreateNewGroupScreenFactory {
  Widget create(BuildContext context);
}

abstract class ICreateNewChannelScreenFactory {
  Widget create(BuildContext context);
}

abstract class ICreateNewSecretChatScreenFactory {
  Widget create(BuildContext context);
}
