import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';
import 'package:tile/tile.dart';

import 'mesage_showcase_component.dart';
import 'mesage_showcase_component.jugger.dart';
import 'message_bundle.dart';
import 'message_showcase_page.dart';
import 'message_showcase_view_model.dart';

class MessageShowcaseFactory {
  Widget create(BuildContext context, MessageBundle bundle) {
    return Scope<IMessageShowcaseComponent>(
      create: () => JuggerMessageShowcaseComponentBuilder()
          .localizationManager(context.read())
          .messageBundle(bundle)
          .build(),
      providers: (IMessageShowcaseComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<MessageShowcaseViewModel>(
            create: (_) => component.getMessageShowcaseViewModel(),
          ),
          Provider<ILocalizationManager>(
            create: (_) => component.getLocalizationManager(),
          ),
          Provider<TileFactory>(
            create: (_) => component.getTileFactory(),
          ),
        ];
      },
      child: const MessageShowcasePage(),
    );
  }
}
