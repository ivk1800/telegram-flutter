import 'package:tile/src/tile_factory.dart';

import 'tile_factory_delegate.dart';
import 'tile_model.dart';

class CompositeTileFactory extends TileFactory {
  CompositeTileFactory({
    required List<TileFactory> factories,
  }) : super(
          delegates: factories
              .map(
                (TileFactory e) =>
                    Map<Type, ITileFactoryDelegate<ITileModel>>.from(
                  e.delegates,
                ),
              )
              .reduce(
                (
                  Map<Type, ITileFactoryDelegate<ITileModel>> value,
                  Map<Type, ITileFactoryDelegate<ITileModel>> element,
                ) =>
                    value..addAll(element),
              ),
        );
}
