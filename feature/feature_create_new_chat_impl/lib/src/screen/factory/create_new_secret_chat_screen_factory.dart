import 'package:core_arch/core_arch.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_secret_chat/new_secret_chat_model.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_secret_chat/new_secret_chat_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

class CreateNewSecretChatScreenFactory
    implements ICreateNewSecretChatScreenFactory {
  CreateNewSecretChatScreenFactory({
    required CreateNewChatComponent component,
  }) : _component = component;

  final CreateNewChatComponent _component;

  @override
  Widget create() {
    return Scope<CreateNewSecretChatScreenComponent>(
      create: () => JuggerCreateNewSecretChatScreenComponentBuilder()
          .createNewChatComponent(_component)
          .build(),
      providers: (CreateNewSecretChatScreenComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<NewSecretChatViewModel>(
            create: (_) => component.getNewSecretChatViewModel(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          ),
        ];
      },
      child: const NewSecretChatPage(),
    );
  }
}
