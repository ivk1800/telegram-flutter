import 'package:feature_chat_administration_impl/src/chat_administration_feature_dependencies.dart';
import 'package:feature_chat_administration_impl/src/screen/chat_administration/args.dart';
import 'package:jugger/jugger.dart' as j;

import 'chat_administration_screen_component.dart';

@j.componentBuilder
abstract class IChatAdministrationScreenComponentBuilder {
  IChatAdministrationScreenComponentBuilder dependencies(
    ChatAdministrationFeatureDependencies dependencies,
  );

  IChatAdministrationScreenComponentBuilder args(Args args);

  IChatAdministrationScreenComponent build();
}
