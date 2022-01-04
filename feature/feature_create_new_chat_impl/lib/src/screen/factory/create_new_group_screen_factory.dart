import 'package:core_arch/core_arch.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_group/new_group_model.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_group/new_group_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

class CreateNewGroupScreenFactory implements ICreateNewGroupScreenFactory {
  CreateNewGroupScreenFactory({
    required CreateNewChatComponent component,
  }) : _component = component;

  final CreateNewChatComponent _component;

  @override
  Widget create() {
    return Scope<CreateNewGroupScreenComponent>(
      create: () => JuggerCreateNewGroupScreenComponentBuilder()
          .createNewChatComponent(_component)
          .build(),
      providers: (CreateNewGroupScreenComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<NewGroupViewModel>(
            create: (_) => component.getNewGroupViewModel(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          ),
        ];
      },
      child: const NewGroupPage(),
    );
  }
}
