import 'package:core_arch/core_arch.dart';
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
    required CreateNewChannelScreenComponent component,
  }) : _component = component;

  final CreateNewChannelScreenComponent _component;

  @override
  Widget create() {
    return Scope<CreateNewChannelScreenComponent>(
      create: () => _component,
      providers: (CreateNewChannelScreenComponent component) {
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
