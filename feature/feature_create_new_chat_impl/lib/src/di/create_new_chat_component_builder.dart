import 'package:feature_create_new_chat_impl/src/create_new_chat_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'create_new_chat_component.dart';

@j.componentBuilder
abstract class ICreateNewChatComponentBuilder {
  ICreateNewChatComponentBuilder dependencies(
    CreateNewChatFeatureDependencies dependencies,
  );

  ICreateNewChatComponent build();
}
