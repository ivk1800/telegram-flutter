import 'package:flutter/widgets.dart';

abstract class ITileFactoryDelegate<M> {
  Widget create(BuildContext context, M model);
}
