import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'chat_settings_view_model.dart';

class ChatSettingsPage extends StatefulWidget {
  const ChatSettingsPage({Key? key}) : super(key: key);

  @override
  ChatSettingsPageState createState() => ChatSettingsPageState();
}

class ChatSettingsPageState extends State<ChatSettingsPage>
    with
        TickerProviderStateMixin,
        StateInjectorMixin<ChatSettingsPage, ChatSettingsPageState> {
  @j.inject
  late ILocalizationManager localizationManager;

  @j.inject
  late ChatSettingsViewModel viewModel;

  @j.inject
  late ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
            context,
            (_) => connectionStateWidgetFactory.create(context,
                (_) => Text(localizationManager.getString('ChatSettings')))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const tg.SectionDivider(),
          tg.TextCell(
            onTap: viewModel.onStickersAndMasksTap,
            title: localizationManager.getString('StickersAndMasks'),
          )
        ],
      ),
    );
  }
}
