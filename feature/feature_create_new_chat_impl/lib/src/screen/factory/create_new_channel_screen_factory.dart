import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_channel/new_channel_model.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_channel/new_channel_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

class CreateNewChannelScreenFactory implements ICreateNewChannelScreenFactory {
  CreateNewChannelScreenFactory({
    required ICreateNewChatComponent component,
  }) : _component = component;

  final ICreateNewChatComponent _component;

  @override
  Widget create() {
    return Scope<ICreateNewChannelScreenComponent>(
      create: () => JuggerCreateNewChannelScreenComponentBuilder()
          .createNewChatComponent(_component)
          .build(),
      providers: (ICreateNewChannelScreenComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<NewChannelViewModel>(
            create: (_) => component.getNewChannelViewModel(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          ),
        ];
      },
      child: const NewChannelPage(),
    );
  }
}
