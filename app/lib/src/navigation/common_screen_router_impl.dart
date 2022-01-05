import 'package:app/src/feature/feature.dart';
import 'package:app/src/navigation/dialog_router_impl.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:dialog_api/dialog_api.dart' as dialog_api;
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_chat_api/feature_chat_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_settings_api/feature_chat_settings_api.dart';
import 'package:feature_chat_settings_impl/feature_chat_settings_impl.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_folders_api/feature_folders_api.dart';
import 'package:feature_folders_impl/feature_folders_impl.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_logout_api/feature_logout_api.dart';
import 'package:feature_logout_impl/feature_logout_impl.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_notifications_settings_impl/feature_notifications_settings_impl.dart';
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_privacy_settings_impl/feature_privacy_settings_impl.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_sessions_api/feature_chat_api.dart';
import 'package:feature_sessions_impl/feature_sessions_impl.dart';
import 'package:feature_settings_api/feature_settings_api.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_wallpapers_api/feature_wallpapers_api.dart';
import 'package:feature_wallpapers_impl/feature_wallpapers_impl.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:split_view/split_view.dart';

import 'navigation_router.dart';

class CommonScreenRouterImpl
    implements
        IFoldersRouter,
        IChatScreenRouter,
        IStickersFeatureRouter,
        ISettingsScreenRouter,
        ISessionsScreenRouter,
        ICreateNewChatRouter,
        IPrivacySettingsScreenRouter,
        INotificationsSettingsScreenRouter,
        IDataSettingsScreenRouter,
        IChatSettingsScreenRouter,
        ISettingsSearchScreenRouter,
        IDevFeatureRouter,
        IMainScreenRouter,
        IWallpapersFeatureRouter,
        IProfileFeatureRouter,
        IGlobalSearchFeatureRouter,
        IDialogRouter,
        ILogoutFeatureRouter,
        IAuthFeatureRouter {
  @j.inject
  CommonScreenRouterImpl({
    required ISplitNavigationDelegate navigationDelegate,
    required GlobalKey<NavigatorState> dialogNavigatorKey,
    required FeatureFactory featureFactory,
  })  : _navigationDelegate = navigationDelegate,
        _dialogNavigatorKey = dialogNavigatorKey,
        _dialogRouter =
            DialogRouterImpl(dialogNavigatorKey: dialogNavigatorKey),
        _featureFactory = featureFactory;

  final ISplitNavigationDelegate _navigationDelegate;
  final FeatureFactory _featureFactory;
  final GlobalKey<NavigatorState> _dialogNavigatorKey;
  final DialogRouterImpl _dialogRouter;

  // TODO extract chat router delegate
  @override
  void toChat(int id) {
    final IChatScreenFactory factory =
        _featureFactory.createChatFeatureApi().chatScreenFactory;
    _add(
      widget: factory.create(id),
      container: ContainerType.right,
    );
  }

  @override
  void toChatProfile(int chatId) {
    final IProfileScreenFactory factory =
        _featureFactory.createProfileFeatureApi().profileScreenFactory;
    _add(
      widget: factory.create(chatId),
      container: ContainerType.top,
    );
  }

  @override
  void toSharedMedia(SharedContentType type) {
    final ISharedMediaScreenFactory factory =
        _featureFactory.createSharedMediaFeatureApi().sharedMediaScreenFactory;
    _add(
      widget: factory.create(type),
      container: ContainerType.top,
    );
  }

  @override
  void toQuickNotificationSettings() {
    final IQuickNotificationSettingsScreenFactory factory = _featureFactory
        .createNotificationsSettingsFeatureApi()
        .quickNotificationSettingsScreenFactory;
    _showDialog(
      // todo pass widget instead call method
      builder: (BuildContext context) => factory.create(),
    );
  }

  @override
  void toChooseCountry(void Function(Country country) callback) {
    final IChooseCountryScreenFactory factory =
        _featureFactory.createCountryFeatureApi().chooseCountryScreenFactory;
    _add(
      widget: factory.create(callback),
      container: ContainerType.top,
    );
  }

  @override
  void toDialog({
    String? title,
    required Body body,
    List<dialog_api.Action> actions = const <dialog_api.Action>[],
  }) =>
      _dialogRouter.toDialog(
        title: title,
        body: body,
        actions: actions,
      );

  @override
  void toAddAccount() {
    _showNotImplementedDialog();
  }

  @override
  void toChangeNumber() {
    _showNotImplementedDialog();
  }

  @override
  void toPasscodeSettings() {
    _showNotImplementedDialog();
  }

  @override
  void toStorageUsageSettings() {
    _showNotImplementedDialog();
  }

  @override
  void toArchivedStickers() {
    final IArchivedStickersWidgetFactory factory = _featureFactory
        .createStickersFeatureApi()
        .archivedStickersWidgetFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toMasks() {
    final IMasksWidgetFactory factory =
        _featureFactory.createStickersFeatureApi().masksWidgetFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toStickerSet(int setId) {
    final IStickerSetWidgetFactory factory =
        _featureFactory.createStickersFeatureApi().stickerSetWidgetFactory;
    _add(
      widget: factory.create(setId),
      container: ContainerType.top,
    );
  }

  @override
  void toTrendingStickers() {
    final ITrendingStickersWidgetFactory factory = _featureFactory
        .createStickersFeatureApi()
        .trendingStickersWidgetFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toFolders() {
    final IFoldersScreenFactory factory =
        _featureFactory.createFoldersFeatureApi().foldersScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewFolder() {
    final ISetupFolderScreenFactory factory =
        _featureFactory.createFoldersFeatureApi().setupFolderScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toSessions() {
    final ISessionsScreenFactory factory =
        _featureFactory.createSessionsFeatureApi().sessionsScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toPrivacySettings() {
    final IPrivacySettingsWidgetFactory factory =
        _featureFactory.createPrivacySettingsFeatureApi().screenWidgetFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toNotificationsSettings() {
    final INotificationsSettingsWidgetFactory factory = _featureFactory
        .createNotificationsSettingsFeatureApi()
        .screenWidgetFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toDataSettings() {
    final IDataSettingsWidgetFactory factory =
        _featureFactory.createDataSettingsFeatureApi().screenWidgetFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toChatSettings() {
    final IChatSettingsWidgetFactory factory =
        _featureFactory.createChatSettingsFeatureApi().screenWidgetFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toLogOut() {
    final ILogoutScreenFactory factory =
        _featureFactory.createLogoutFeatureApi().logoutScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toStickersAndMasks() {
    final IStickersWidgetFactory factory =
        _featureFactory.createStickersFeatureApi().stickersWidgetFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toWallPapers() {
    final IWallpapersListScreenFactory factory = _featureFactory
        .createWallpapersFeatureApi()
        .wallpapersListScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toEventsList() {
    final DevFeature feature = _featureFactory.createDevFeature();
    _add(
      widget: feature.createEventsListWidget(),
      container: ContainerType.top,
    );
  }

  @override
  void toSettings() {
    final ISettingScreenFactory factory =
        _featureFactory.createSettingsFeatureApi().settingsScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toDev() {
    final DevFeature feature = _featureFactory.createDevFeature();
    _add(
      widget: feature.createRootWidget(),
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewChat() {
    final INewChatScreenFactory factory =
        _featureFactory.createCreateNewChatFeatureApi().newChatScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewChannel() {
    final ICreateNewChannelScreenFactory factory = _featureFactory
        .createCreateNewChatFeatureApi()
        .createNewChannelScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewGroup() {
    final ICreateNewGroupScreenFactory factory = _featureFactory
        .createCreateNewChatFeatureApi()
        .createNewGroupScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewSecretChat() {
    final ICreateNewSecretChatScreenFactory factory = _featureFactory
        .createCreateNewChatFeatureApi()
        .createNewSecretChatScreenFactory;
    _add(
      widget: factory.create(),
      container: ContainerType.top,
    );
  }

  void _showDialog({required WidgetBuilder builder}) {
    final BuildContext? context = _dialogNavigatorKey.currentContext;

    if (context == null) {
      return;
    }

    showDialog<dynamic>(
      context: context,
      builder: builder,
    );
  }

  void _showNotImplementedDialog() {
    toDialog(
      body: const Body.text(text: 'not implemented'),
    );
  }

  void _add({
    required Widget widget,
    required ContainerType container,
  }) {
    _navigationDelegate.push(
      key: UniqueKey(),
      builder: (_) => widget,
      container: container,
    );
  }

  @override
  void back() {
    _navigationDelegate.back();
  }
}
