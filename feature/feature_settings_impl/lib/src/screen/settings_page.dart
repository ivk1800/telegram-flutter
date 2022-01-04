import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_impl/src/screen/setting_view_model.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  late GlobalObjectKey<tg.TgSwitchedAppBarState> _appbarKey;

  _ScreenState _screenState = _ScreenState.settings;

  final FocusNode _searchQueryFocusNode = FocusNode();
  final TextEditingController _searchQueryController = TextEditingController();

  final SettingsSearchScreenController _settingsSearchScreenController =
      SettingsSearchScreenController();

  late Widget _searchWidget;

  @override
  void initState() {
    _searchWidget = context
        .read<ISettingsSearchScreenFactory>()
        .create(_settingsSearchScreenController);
    _appbarKey = _AppBarKey(hashCode);
    _searchQueryController.addListener(_onSearchEvent);
    super.initState();
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchEvent);
    _settingsSearchScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_screenState != _ScreenState.settings) {
          setState(() {
            _screenState = _ScreenState.settings;
            _searchQueryController.text = '';
            _appbarKey.currentState?.setActive(active: false);
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: tg.TgSwitchedAppBar(
          key: _appbarKey,
          backgroundColor: AppBarTheme.of(context).backgroundColor!,
          appBarBuilder: (
            AnimationController animationController,
            BuildContext context,
            bool isActive,
          ) {
            if (isActive) {
              return tg.SearchAppBar(
                focusNode: _searchQueryFocusNode,
                isOverrideLeading: false,
                searchQueryController: _searchQueryController,
                animationController: animationController,
                onLeadingTap: () {
                  if (_screenState == _ScreenState.search) {
                    setState(() {
                      _screenState = _ScreenState.settings;
                      _searchQueryController.text = '';
                      _appbarKey.currentState?.setActive(active: false);
                    });
                  } else if (_screenState == _ScreenState.settings) {
                    Navigator.of(context).pop();
                  }
                },
              );
            } else {
              final tg.ConnectionStateWidgetFactory
                  connectionStateWidgetFactory = context.read();
              return AppBar(
                title: Align(
                  child: connectionStateWidgetFactory.create(
                    context,
                    (BuildContext context) {
                      return Text(
                        context
                            .read<ILocalizationManager>()
                            .getString('AppName'),
                      );
                    },
                  ),
                  alignment: Alignment.centerLeft,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _screenState = _ScreenState.search;
                        _searchQueryFocusNode.requestFocus();
                        _appbarKey.currentState?.setActive(active: true);
                      });
                    },
                  ),
                  _AppBarPopupMenu(
                    onSelected: (_AppBarMenu value) {
                      switch (value) {
                        case _AppBarMenu.logOut:
                          context.read<SettingViewModel>().onLogOutTap();
                          break;
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
        body: Stack(
          children: <Widget>[
            const SingleChildScrollView(child: _Body()),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _screenState == _ScreenState.search
                  ? Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: _searchWidget,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchEvent() =>
      _settingsSearchScreenController.onQuery(_searchQueryController.text);
}

enum _AppBarMenu { logOut }

enum _ScreenState { settings, search }

class AppBarPopupMenuItem extends StatelessWidget {
  const AppBarPopupMenuItem({
    Key? key,
    required this.title,
  }) : super(key: key);

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
  const _AppBarPopupMenu({Key? key, required this.onSelected})
      : super(key: key);

  final PopupMenuItemSelected<_AppBarMenu> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_AppBarMenu>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_AppBarMenu>>[
        const PopupMenuItem<_AppBarMenu>(
          value: _AppBarMenu.logOut,
          child: AppBarPopupMenuItem(
            // todo extract string
            title: 'Log out',
          ),
        ),
      ],
    );
  }
}

class _AppBarKey extends GlobalObjectKey<tg.TgSwitchedAppBarState> {
  const _AppBarKey(Object value) : super(value);
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).colorScheme.secondary;

    final SettingViewModel viewModel = context.read();

    final ILocalizationManager localizationManager = context.read();
    String _getString(String key) => localizationManager.getString(key);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        tg.TextCell(
          titleColor: accentColor,
          leading: Icon(
            Icons.add_a_photo_outlined,
            color: accentColor,
          ),
          title: _getString('SetProfilePhoto'),
        ),
        const tg.SectionDivider(),
        tg.Section(
          text: _getString('Account'),
        ),
        tg.TextCell(
          title: '123',
          subtitle: _getString('TapToChangePhone'),
        ),
        const tg.Divider(),
        tg.TextCell(
          title: 'None',
          subtitle: _getString('Username'),
        ),
        const tg.Divider(),
        tg.TextCell(
          title: _getString('UserBio'),
          subtitle: _getString('UserBioDetail'),
        ),
        const tg.SectionDivider(),
        tg.Section(
          text: _getString('Settings'),
        ),
        tg.TextCell(
          onTap: viewModel.onNotificationsSettingsTap,
          leading: const Icon(Icons.notifications_none),
          title: _getString('NotificationsAndSounds'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onPrivacySettingsTap,
          leading: const Icon(Icons.lock_open),
          title: _getString('PrivacySettings'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onDataSettingsTap,
          leading: const Icon(Icons.data_usage),
          title: _getString('DataSettings'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onChatSettingsTap,
          leading: const Icon(Icons.chat_bubble_outline),
          title: _getString('ChatSettings'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onFoldersTap,
          leading: const Icon(Icons.folder),
          title: _getString('Filters'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: viewModel.onSessionsTap,
          leading: const Icon(Icons.devices_sharp),
          title: _getString('Devices'),
        ),
        const tg.SectionDivider(),
        tg.Section(
          text: _getString('SettingsHelp'),
        ),
        tg.TextCell(
          leading: const Icon(Icons.chat),
          title: _getString('AskAQuestion'),
        ),
        const tg.Divider(),
        tg.TextCell(
          leading: const Icon(Icons.help_outline),
          title: _getString('TelegramFAQ'),
        ),
        const tg.Divider(),
        tg.TextCell(
          leading: const Icon(Icons.shield),
          title: _getString('PrivacyPolicy'),
        ),
        const tg.Annotation(
          align: TextAlign.center,
          text: 'Todo: add app version information',
        ),
      ],
    );
  }
}
