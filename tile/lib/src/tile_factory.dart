import 'package:flutter/widgets.dart';

import 'tile_factory_delegate.dart';
import 'tile_model.dart';

class TileFactory {
  const TileFactory({required this.delegates});

  final Map<Type, ITileFactoryDelegate<ITileModel>> delegates;

  Widget create(BuildContext context, ITileModel model) {
    assert(
      delegates.containsKey(model.runtimeType),
      'missing delegate for type ${model.runtimeType}',
    );
    return delegates[model.runtimeType]!.create(context, model);
  }

  Widget createIndexed(
    BuildContext context,
    List<ITileModel> models,
    int index,
  ) {
    return create(context, models[index]);
  }
}
