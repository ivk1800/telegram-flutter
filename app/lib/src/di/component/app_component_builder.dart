import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'app_component.dart';

@j.componentBuilder
abstract class IAppComponentBuilder {
  IAppComponentBuilder localizationManager(
    ILocalizationManager localizationManager,
  );

  IAppComponent build();
}
