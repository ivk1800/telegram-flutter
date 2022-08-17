import 'package:feature_chat_impl/src/component/message_tile_factory_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

import 'message_tile_factory_component.dart';

@j.componentBuilder
abstract class IMessageTileFactoryComponentBuilder {
  IMessageTileFactoryComponentBuilder dependencies(
    MessageTileFactoryDependencies dependencies,
  );

  IMessageTileFactoryComponent build();
}
