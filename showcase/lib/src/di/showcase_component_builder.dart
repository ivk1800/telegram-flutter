import 'package:jugger/jugger.dart' as j;
import 'package:showcase/showcase.dart';
import 'package:showcase/src/di/showcase_component.dart';

@j.componentBuilder
abstract class IShowcaseComponentBuilder {
  IShowcaseComponentBuilder dependencies(
    ShowcaseDependencies dependencies,
  );

  IShowcaseComponent build();
}
