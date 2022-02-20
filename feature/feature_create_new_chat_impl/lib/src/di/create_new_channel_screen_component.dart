import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import '../screen/new_channel/new_channel.dart';
import 'create_new_chat_component.dart';

@j.Component(
  dependencies: <Type>[ICreateNewChatComponent],
  modules: <Type>[CreateNewChannelScreenModule],
)
abstract class ICreateNewChannelScreenComponent {
  NewChannelViewModel getNewChannelViewModel();

  ILocalizationManager getLocalizationManager();
}

@j.module
abstract class CreateNewChannelScreenModule {
  @j.singleton
  @j.provides
  static NewChannelViewModel provideNewChannelViewModel() =>
      NewChannelViewModel()..init();
}

@j.componentBuilder
abstract class ICreateNewChannelScreenComponentBuilder {
  ICreateNewChannelScreenComponentBuilder createNewChatComponent(
    ICreateNewChatComponent component,
  );

  ICreateNewChannelScreenComponent build();
}
