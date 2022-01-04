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
    required CreateNewGroupScreenComponent component,
  }) : _component = component;

  final CreateNewGroupScreenComponent _component;

  @override
  Widget create() {
    return Scope<CreateNewGroupScreenComponent>(
      create: () => _component,
      providers: (CreateNewGroupScreenComponent component) {
        return <Provider<dynamic>>[
          Provider<NewGroupViewModel>(
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
