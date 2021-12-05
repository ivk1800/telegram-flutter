import 'package:coreui/coreui.dart' as tg;
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>
    with
        TickerProviderStateMixin,
        StateInjectorMixin<SettingsPage, SettingsPageState> {
  late GlobalObjectKey<tg.TgSwitchedAppBarState> _appbarKey;

  @j.inject
  late ILocalizationManager localizationManager;

  @j.inject
  late ISettingsScreenRouter router;

  @j.inject
  late tg.ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @j.inject
  late ISettingsSearchWidgetFactory settingsSearchWidgetFactory;

  _ScreenState _screenState = _ScreenState.settings;

  final FocusNode _searchQueryFocusNode = FocusNode();
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appbarKey = _AppBarKey(hashCode);
    _searchQueryController.addListener(_onSearchEvent);
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchEvent);
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
              return AppBar(
                title: _buildTitleWidget(context),
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
                          router.toLogOut();
                          break;
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
        body: _buildBody(context),
      ),
    );
  }

  void _onSearchEvent() {}

  Widget _buildBody(BuildContext context) => Stack(
        children: <Widget>[
          SingleChildScrollView(child: _buildDefaultWidget(context)),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _screenState == _ScreenState.search
                ? _buildSearchWidget(context)
                : null,
          ),
        ],
      );

  Widget _buildSearchWidget(BuildContext context) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: settingsSearchWidgetFactory.create(),
      );

  Widget _buildDefaultWidget(BuildContext context) {
    final Color accentColor = Theme.of(context).colorScheme.secondary;
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
          onTap: router.toNotificationsSettings,
          leading: const Icon(Icons.notifications_none),
          title: _getString('NotificationsAndSounds'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: router.toPrivacySettings,
          leading: const Icon(Icons.lock_open),
          title: _getString('PrivacySettings'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: router.toDataSettings,
          leading: const Icon(Icons.data_usage),
          title: _getString('DataSettings'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: router.toChatSettings,
          leading: const Icon(Icons.chat_bubble_outline),
          title: _getString('ChatSettings'),
        ),
        const tg.Divider(),
        tg.TextCell(
          onTap: router.toFolders,
          leading: const Icon(Icons.folder),
          title: _getString('Filters'),
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

  Widget _buildTitleWidget(BuildContext context) {
    return Align(
      child:
          connectionStateWidgetFactory.create(context, (BuildContext context) {
        // TODO extract text to stings
        return const Text('Telegram');
      }),
      alignment: Alignment.centerLeft,
    );
  }

  String _getString(String key) => localizationManager.getString(key);
}

enum _AppBarMenu { logOut }

enum _ScreenState { settings, search }

class AppBarPopupMenuItem extends StatelessWidget {
  const AppBarPopupMenuItem({Key? key, required this.title}) : super(key: key);

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
