import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_impl/src/screen/setting_view_model.dart';
import 'package:feature_settings_impl/src/screen/settings_screen_scope_delegate.scope.dart';
import 'package:feature_settings_impl/src/screen/settings_screen_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'content_state.dart';
import 'settings_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final SettingsScreenWidgetModel settingsScreenWidgetModel =
        SettingsScreenScope.getSettingsScreenWidgetModel(context);

    return WillPopScope(
      onWillPop: settingsScreenWidgetModel.onWillPop,
      child: const Scaffold(
        appBar: _AppBar(),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final SettingViewModel settingsScreenViewModel =
        SettingsScreenScope.getSettingViewModel(context);

    return Stack(
      children: <Widget>[
        StreamListener<ContentState>(
          stream: settingsScreenViewModel.stateStream,
          builder: (BuildContext context, ContentState state) {
            return _SettingsBody(state: state);
          },
        ),
        const _SearchBody(),
      ],
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    final SettingsScreenWidgetModel settingsScreenWidgetModel =
        SettingsScreenScope.getSettingsScreenWidgetModel(context);

    return ValueListenableBuilder<ScreenState>(
      valueListenable: settingsScreenWidgetModel.screenState,
      builder: (BuildContext context, ScreenState screenState, Widget? child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: screenState == ScreenState.search
              ? Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: settingsScreenWidgetModel.searchWidget,
                )
              : null,
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final SettingsScreenWidgetModel settingsScreenWidgetModel =
        SettingsScreenScope.getSettingsScreenWidgetModel(context);

    return tg.TgSwitchedAppBar(
      key: settingsScreenWidgetModel.appbarKey,
      backgroundColor: AppBarTheme.of(context).backgroundColor,
      appBarBuilder: (
        AnimationController animationController,
        BuildContext context, {
        required bool isActive,
      }) {
        if (isActive) {
          return tg.SearchAppBar(
            focusNode: settingsScreenWidgetModel.searchQueryFocusNode,
            isOverrideLeading: false,
            searchQueryController:
                settingsScreenWidgetModel.searchQueryController,
            animationController: animationController,
            onLeadingTap: settingsScreenWidgetModel.onLeadingTap,
          );
        } else {
          final SettingViewModel settingsScreenViewModel =
              SettingsScreenScope.getSettingViewModel(context);

          return StreamListener<ContentState>(
            stream: settingsScreenViewModel.stateStream,
            builder: (BuildContext context, ContentState state) {
              return _SettingsStateAppBar(state: state);
            },
          );
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _SettingsStateAppBar extends StatelessWidget {
  const _SettingsStateAppBar({required this.state});

  final ContentState state;

  @override
  Widget build(BuildContext context) {
    return state.map(
      loading: (_) {
        return AppBar(
          title: Text(
            SettingsScreenScope.getStringsProvider(context).appName,
          ),
        );
      },
      data: (ContentStateData data) {
        final SettingsScreenWidgetModel settingsScreenWidgetModel =
            SettingsScreenScope.getSettingsScreenWidgetModel(context);

        final TextTheme primaryTextTheme = Theme.of(context).primaryTextTheme;
        return AppBar(
          titleSpacing: 0.0,
          title: Align(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: tg.AvatarWidget(
                factory: SettingsScreenScope.getAvatarWidgetFactory(context),
                avatar: data.appBarState.avatar,
              ),
              title: Text(
                data.appBarState.name,
                maxLines: 1,
                style: primaryTextTheme.titleMedium,
              ),
              subtitle: Text(
                data.appBarState.onlineStatus,
                maxLines: 1,
                style: primaryTextTheme.bodySmall,
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: settingsScreenWidgetModel.onSearchTap,
            ),
            _AppBarPopupMenu(
              onSelected: settingsScreenWidgetModel.onAppBarMenuTap,
            ),
          ],
        );
      },
    );
  }
}

class _AppBarPopupMenuItem extends StatelessWidget {
  const _AppBarPopupMenuItem({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.circle),
      title: Text(title),
    );
  }
}

class _AppBarPopupMenu extends StatelessWidget {
  const _AppBarPopupMenu({required this.onSelected});

  final PopupMenuItemSelected<AppBarMenu> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppBarMenu>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<AppBarMenu>>[
        const PopupMenuItem<AppBarMenu>(
          value: AppBarMenu.logOut,
          child: _AppBarPopupMenuItem(
            // todo extract string
            title: 'Log out',
          ),
        ),
      ],
    );
  }
}

class _SettingsBody extends StatelessWidget {
  const _SettingsBody({
    required this.state,
  });

  final ContentState state;

  @override
  Widget build(BuildContext context) {
    return state.map(
      loading: (_) {
        return const Center(child: CircularProgressIndicator());
      },
      data: (ContentStateData data) {
        return SingleChildScrollView(child: _SettingsBodyContent(data: data));
      },
    );
  }
}

class _SettingsBodyContent extends StatelessWidget {
  const _SettingsBodyContent({
    required this.data,
  });

  final ContentStateData data;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).colorScheme.secondary;

    final SettingViewModel viewModel =
        SettingsScreenScope.getSettingViewModel(context);

    final IStringsProvider stringsProvider =
        SettingsScreenScope.getStringsProvider(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        tg.TextCell(
          titleColor: accentColor,
          leading: Icon(
            Icons.add_a_photo_outlined,
            color: accentColor,
          ),
          title: stringsProvider.setProfilePhoto,
        ),
        const tg.SectionDivider(),
        tg.Section(
          text: stringsProvider.account,
        ),
        tg.TextCell(
          title: data.bodyState.phoneNumberFormatted,
          subtitle: stringsProvider.tapToChangePhone,
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onUsernameTap,
          title: data.bodyState.username,
          subtitle: stringsProvider.username,
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onBioTap,
          title: stringsProvider.userBio,
          subtitle: stringsProvider.userBioDetail,
        ),
        const tg.SectionDivider(),
        tg.Section(
          text: stringsProvider.settings,
        ),
        tg.TextCell(
          onTap: viewModel.onNotificationsSettingsTap,
          leading: const Icon(Icons.notifications_none),
          title: stringsProvider.notificationsAndSounds,
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onPrivacySettingsTap,
          leading: const Icon(Icons.lock_open),
          title: stringsProvider.privacySettings,
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onDataSettingsTap,
          leading: const Icon(Icons.data_usage),
          title: stringsProvider.dataSettings,
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onChatSettingsTap,
          leading: const Icon(Icons.chat_bubble_outline),
          title: stringsProvider.chatSettings,
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onFoldersTap,
          leading: const Icon(Icons.folder),
          title: stringsProvider.filters,
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onSessionsTap,
          leading: const Icon(Icons.devices_sharp),
          title: stringsProvider.devices,
        ),
        const tg.SectionDivider(),
        tg.Section(
          text: stringsProvider.settingsHelp,
        ),
        tg.TextCell(
          leading: const Icon(Icons.chat),
          title: stringsProvider.askAQuestion,
        ),
        const tg.Divider(),
        tg.TextCell(
          leading: const Icon(Icons.help_outline),
          title: stringsProvider.telegramFAQ,
        ),
        const tg.Divider(),
        tg.TextCell(
          leading: const Icon(Icons.shield),
          title: stringsProvider.privacyPolicy,
        ),
        const tg.Annotation(
          align: TextAlign.center,
          text: 'Todo: add app version information',
        ),
      ],
    );
  }
}
