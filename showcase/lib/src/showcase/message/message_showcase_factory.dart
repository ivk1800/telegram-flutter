import 'package:flutter/cupertino.dart';
import 'package:localization_api/localization_api.dart';

import 'message_bundle.dart';
import 'message_showcase_component.jugger.dart';
import 'message_showcase_page.dart';
import 'message_showcase_scope.dart';

class MessageShowcaseFactory {
  MessageShowcaseFactory({
    required IStringsProvider stringsProvider,
  }) : _stringsProvider = stringsProvider;

  final IStringsProvider _stringsProvider;

  Widget create(MessageBundle bundle) {
    return MessageShowcaseScope(
      child: const MessageShowcasePage(),
      create: () => JuggerMessageShowcaseComponentBuilder()
          .stringsProvider(_stringsProvider)
          .messageBundle(bundle)
          .build(),
    );
  }
}
