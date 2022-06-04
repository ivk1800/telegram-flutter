import 'package:tile/tile.dart';

import 'message_tile_factory_component.jugger.dart';
import 'message_tile_factory_dependencies.dart';

class MessageTileFactory {
  MessageTileFactory({
    required MessageTileFactoryDependencies dependencies,
  }) : _dependencies = dependencies;

  final MessageTileFactoryDependencies _dependencies;

  TileFactory create() {
    return JuggerMessageTileFactoryComponentBuilder()
        .dependencies(_dependencies)
        .build()
        .getTileFactory();
  }
}
