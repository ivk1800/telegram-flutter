import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

import 'chat_settings_event.dart';
import 'chat_settings_view_model.dart';

class ChatSettingsPage extends StatefulWidget {
  const ChatSettingsPage({super.key});

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
          (_) => Text(localizationManager.getString('ChatSettings')),
        ),
      ),
      body: const SingleChildScrollView(child: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager =
        Provider.of(context, listen: false);
    final ChatSettingsViewModel bloc = Provider.of(context, listen: false);
    final ThemeData theme = Theme.of(context);
    final Color accentColor = theme.colorScheme.secondary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const tg.SectionDivider(),
        tg.TextCell(
          onTap: () => bloc.onEvent(const WallpapersTap()),
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
          onTap: () {},
          value: true,
          title: localizationManager.getString('AutoNightTheme'),
          subtitle: 'todo',
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          value: true,
          subtitle: localizationManager.getString('ChromeCustomTabs'),
          title: localizationManager.getString('ChromeCustomTabsInfo'),
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          value: true,
          subtitle: localizationManager.getString('DirectShare'),
          title: localizationManager.getString('DirectShareInfo'),
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          value: true,
          title: localizationManager.getString('EnableAnimations'),
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          value: true,
          title: localizationManager.getString('LargeEmoji'),
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          value: true,
          title: localizationManager.getString('RaiseToSpeak'),
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          value: true,
          title: localizationManager.getString('SendByEnter'),
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          value: true,
          title: localizationManager.getString('SaveToGallerySettings'),
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.toggle(
          value: true,
          title: localizationManager.getString('DistanceUnits'),
          onChanged: (bool v) {},
        ),
        const tg.Divider(),
        tg.TextCell.textValue(
          value: localizationManager.getString('DistanceUnitsAutomatic'),
          title: localizationManager.getString('DistanceUnits'),
        ),
        const tg.SectionDivider(),
        tg.TextCell(
          onTap: () => bloc.onEvent(const StickersAndMasksTap()),
          title: localizationManager.getString('StickersAndMasks'),
        ),
        const tg.SectionDivider(),
      ],
    );
  }
}
