import 'package:feature_stickers_impl/src/di/stickers_set_screen/stickers_set_screen_component.dart';
import 'package:jugger/jugger.dart' as j;

@j.componentBuilder
abstract class IStickersSetScreenComponentBuilder {
  IStickersSetScreenComponentBuilder setId(int setId);

  IStickersSetScreenComponent build();
}
