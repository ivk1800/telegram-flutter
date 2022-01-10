import 'package:feature_create_new_chat_impl/src/screen/new_channel/new_channel_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'create_new_chat_component.dart';

@j.Component(
  dependencies: <Type>[CreateNewChatComponent],
  modules: <Type>[CreateNewChannelScreenModule],
)
abstract class CreateNewChannelScreenComponent {
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
abstract class CreateNewChannelScreenComponentBuilder {
  CreateNewChannelScreenComponentBuilder createNewChatComponent(
    CreateNewChatComponent component,
  );

  CreateNewChannelScreenComponent build();
}
