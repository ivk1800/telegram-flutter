import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/src/di/di.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat_page.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_chat/new_chat_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

class NewChatScreenFactory implements INewChatScreenFactory {
  NewChatScreenFactory({
    required CreateNewChatScreenComponent component,
  }) : _component = component;

  final CreateNewChatScreenComponent _component;

  @override
  Widget create() {
    return Scope<CreateNewChatScreenComponent>(
      create: () => _component,
      providers: (CreateNewChatScreenComponent component) {
        return <Provider<dynamic>>[
          Provider<NewChatViewModel>(
            create: (_) => component.getNewChatViewModel(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          )
        ];
      },
      child: const NewChatPage(),
    );
  }
}
