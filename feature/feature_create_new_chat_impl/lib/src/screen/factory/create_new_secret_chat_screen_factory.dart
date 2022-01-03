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
    required CreateNewSecretChatScreenComponent component,
  }) : _component = component;

  final CreateNewSecretChatScreenComponent _component;

  @override
  Widget create() {
    return Scope<CreateNewSecretChatScreenComponent>(
      create: () => _component,
      providers: (CreateNewSecretChatScreenComponent component) {
        return <Provider<dynamic>>[
          Provider<NewSecretChatViewModel>(
            create: (_) => component.getNewSecretChatViewModel(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          )
        ];
      },
      child: const NewSecretChatPage(),
    );
  }
}
