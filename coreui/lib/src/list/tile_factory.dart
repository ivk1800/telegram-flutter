import 'package:flutter/widgets.dart';

// todo move to separate module
class TileFactory {
  TileFactory({required this.delegates});

  final Map<Type, ITileFactoryDelegate<ITileModel>> delegates;

  Widget create(BuildContext context, ITileModel model) {
    assert(delegates.containsKey(model.runtimeType),
        'missing delegate for type ${model.runtimeType}');
    return delegates[model.runtimeType]!.create(context, model);
  }

  Widget createIndexed(
      BuildContext context, List<ITileModel> models, int index) {
    return create(context, models[index]);
  }
}

abstract class ITileModel {}

abstract class ITileFactoryDelegate<M> {
  Widget create(BuildContext context, M model);
}
