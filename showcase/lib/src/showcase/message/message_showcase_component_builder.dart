import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'message_bundle.dart';
import 'message_showcase_component.dart';

@j.componentBuilder
abstract class IMessageShowcaseComponentBuilder {
  IMessageShowcaseComponentBuilder stringsProvider(
    IStringsProvider value,
  );

  IMessageShowcaseComponentBuilder messageBundle(
    MessageBundle value,
  );

  IMessageShowcaseComponent build();
}
