import 'package:flutter/material.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

import 'bloc/chat_settings_bloc.dart';
import 'bloc/chat_settings_event.dart';

class ChatSettingsPage extends StatefulWidget {
  const ChatSettingsPage({Key? key}) : super(key: key);

  @override
  ChatSettingsPageState createState() => ChatSettingsPageState();
}

class ChatSettingsPageState extends State<ChatSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Provider.of<tg.ConnectionStateWidgetFactory>(context).create(
            context,
            (_) => Text(localizationManager.getString('ChatSettings'))),
      ),
      body: SingleChildScrollView(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    final ILocalizationManager localizationManager = Provider.of(context);
    final ChatSettingsBloc bloc = BlocProvider.of(context);
    final ThemeData theme = Theme.of(context);
    final Color accentColor = theme.accentColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const tg.SectionDivider(),
        tg.TextCell(
          onTap: () => bloc.add(const WallpapersTap()),
          titleColor: accentColor,
          title: localizationManager.getString('ChangeChatBackground'),
          leading: Icon(
            Icons.photo_library_rounded,
            color: accentColor,
          ),
        ),
        const tg.SectionDivider(),
        const tg.Section(
          text: 'Settings',
        ),
        tg.TextCell.toggle(
            onTap: () {
              print('tap');
            },
            value: true,
            title: localizationManager.getString('AutoNightTheme'),
            subtitle: 'todo',
            onChanged: (bool v) {
              print('tap toggle');
            }),
        const tg.Divider(),
        tg.TextCell.toggle(
            value: true,
            subtitle: localizationManager.getString('ChromeCustomTabs'),
            title: localizationManager.getString('ChromeCustomTabsInfo'),
            onChanged: (bool v) {}),
        const tg.Divider(),
        tg.TextCell.toggle(
            value: true,
            subtitle: localizationManager.getString('DirectShare'),
            title: localizationManager.getString('DirectShareInfo'),
            onChanged: (bool v) {}),
        const tg.Divider(),
        tg.TextCell.toggle(
            value: true,
            title: localizationManager.getString('EnableAnimations'),
            onChanged: (bool v) {}),
        const tg.Divider(),
        tg.TextCell.toggle(
            value: true,
            title: localizationManager.getString('LargeEmoji'),
            onChanged: (bool v) {}),
        const tg.Divider(),
        tg.TextCell.toggle(
            value: true,
            title: localizationManager.getString('RaiseToSpeak'),
            onChanged: (bool v) {}),
        const tg.Divider(),
        tg.TextCell.toggle(
            value: true,
            title: localizationManager.getString('SendByEnter'),
            onChanged: (bool v) {}),
        const tg.Divider(),
        tg.TextCell.toggle(
            value: true,
            title: localizationManager.getString('SaveToGallerySettings'),
            onChanged: (bool v) {}),
        const tg.Divider(),
        tg.TextCell.toggle(
            value: true,
            title: localizationManager.getString('DistanceUnits'),
            onChanged: (bool v) {}),
        const tg.Divider(),
        tg.TextCell.textValue(
            value: localizationManager.getString('DistanceUnitsAutomatic'),
            title: localizationManager.getString('DistanceUnits')),
        const tg.SectionDivider(),
        tg.TextCell(
          onTap: () => bloc.add(const StickersAndMasksTap()),
          title: localizationManager.getString('StickersAndMasks'),
        ),
        const tg.SectionDivider(),
      ],
    );
  }
}
