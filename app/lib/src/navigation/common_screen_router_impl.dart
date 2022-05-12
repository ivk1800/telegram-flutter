import 'package:app/src/feature/feature_provider.dart';
import 'package:app/src/navigation/key_generator.dart';
import 'package:dialog_api/dialog_api.dart' as dialog_api;
import 'package:dialog_api/dialog_api.dart';
import 'package:dialog_api_flutter/dialog_api_flutter.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_settings_impl/feature_chat_settings_impl.dart';
import 'package:feature_contacts_impl/feature_contacts_impl.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:feature_dev/feature_dev.dart';
import 'package:feature_folders_impl/feature_folders_impl.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_logout_impl/feature_logout_impl.dart';
import 'package:feature_main_screen_impl/feature_main_screen_impl.dart';
import 'package:feature_notifications_settings_impl/feature_notifications_settings_impl.dart';
import 'package:feature_privacy_settings_impl/feature_privacy_settings_impl.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_sessions_impl/feature_sessions_impl.dart';
import 'package:feature_settings_impl/feature_settings_impl.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_wallpapers_impl/feature_wallpapers_impl.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

import 'chat_router_delegate.dart';
import 'navigation_router.dart';

class CommonScreenRouterImpl
    implements
        IFoldersRouter,
        IChatScreenRouter,
        IStickersFeatureRouter,
        ISettingsScreenRouter,
        ISessionsScreenRouter,
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
        IContactsRouter,
        IAuthFeatureRouter {
  CommonScreenRouterImpl({
    required ISplitNavigationDelegate navigationDelegate,
    required GlobalKey<NavigatorState> dialogNavigatorKey,
    required FeatureProvider featureProvider,
    required KeyGenerator keyGenerator,
    required ChatRouterDelegate chatRouterDelegate,
  })  : _navigationDelegate = navigationDelegate,
        _dialogNavigatorKey = dialogNavigatorKey,
        _keyGenerator = keyGenerator,
        _chatRouterDelegate = chatRouterDelegate,
        _dialogRouter =
            DialogRouterImpl(dialogNavigatorKey: dialogNavigatorKey),
        _featureProvider = featureProvider;

  final ISplitNavigationDelegate _navigationDelegate;
  final FeatureProvider _featureProvider;
  final ChatRouterDelegate _chatRouterDelegate;
  final GlobalKey<NavigatorState> _dialogNavigatorKey;
  final DialogRouterImpl _dialogRouter;
  final KeyGenerator _keyGenerator;

  @override
  void toChat(int id) => _chatRouterDelegate.toChat(id);

  @override
  void toChatProfile({required int chatId, required ProfileType type}) {
    _add(
      widget: _featureProvider.profileFeatureApi.profileScreenFactory
          .create(chatId, type),
      key: _keyGenerator.generateForChatProfile(chatId),
      container: ContainerType.top,
    );
  }

  @override
  void toSharedMedia(SharedContentType type) {
    _add(
      widget: _featureProvider.sharedMediaFeatureApi.sharedMediaScreenFactory
          .create(type),
      container: ContainerType.top,
    );
  }

  @override
  void toQuickNotificationSettings() {
    final Widget widget = _featureProvider
        .notificationsSettingsFeatureApi.quickNotificationSettingsScreenFactory
        .create();

    _showDialog(
      builder: (_) => widget,
    );
  }

  @override
  void toChooseCountry(void Function(Country country) callback) {
    _add(
      widget: _featureProvider.countryFeatureApi.chooseCountryScreenFactory
          .create(callback),
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
    _add(
      widget: _featureProvider.stickersFeatureApi.archivedStickersWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toMasks() {
    _add(
      widget: _featureProvider.stickersFeatureApi.masksWidgetFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toStickerSet(int setId) {
    _add(
      widget: _featureProvider.stickersFeatureApi.stickerSetWidgetFactory
          .create(setId),
      container: ContainerType.top,
    );
  }

  @override
  void toTrendingStickers() {
    _add(
      widget: _featureProvider.stickersFeatureApi.trendingStickersWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toFolders() {
    _add(
      widget: _featureProvider.foldersFeatureApi.foldersScreenFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewFolder() {
    _add(
      widget:
          _featureProvider.foldersFeatureApi.setupFolderScreenFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toSessions() {
    _add(
      widget:
          _featureProvider.sessionsFeatureApi.sessionsScreenFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toPrivacySettings() {
    _add(
      widget: _featureProvider.privacySettingsFeatureApi.screenWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toNotificationsSettings() {
    _add(
      widget: _featureProvider
          .notificationsSettingsFeatureApi.screenWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toDataSettings() {
    _add(
      widget:
          _featureProvider.dataSettingsFeatureApi.screenWidgetFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toChatSettings() {
    _add(
      widget:
          _featureProvider.chatSettingsFeatureApi.screenWidgetFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toLogOut() {
    _add(
      widget: _featureProvider.logoutFeatureApi.logoutScreenFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toStickersAndMasks() {
    _add(
      widget:
          _featureProvider.stickersFeatureApi.stickersWidgetFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toWallPapers() {
    _add(
      widget: _featureProvider.wallpapersFeatureApi.wallpapersListScreenFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toEventsList() {
    final Widget widget = _featureProvider.devFeature.createEventsListWidget();
    _add(
      widget: widget,
      container: ContainerType.top,
    );
  }

  @override
  void toSettings() {
    _add(
      widget:
          _featureProvider.settingsFeatureApi.settingsScreenFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toDev() {
    final Widget widget = _featureProvider.devFeature.createRootWidget();
    _add(
      widget: widget,
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewChat() {
    _add(
      widget: _featureProvider.newChatFeatureApi.newChatScreenFactory.create(),
      container: ContainerType.top,
      key: _keyGenerator.generateForCreateNewChat(),
    );
  }

  void toCreateNewChannel() {
    _add(
      widget: _featureProvider.newChatFeatureApi.createNewChannelScreenFactory
          .create(),
      key: _keyGenerator.generateForCreateNewChannel(),
      container: ContainerType.top,
    );
  }

  void toCreateNewGroup() {
    _add(
      widget: _featureProvider.newChatFeatureApi.createNewGroupScreenFactory
          .create(),
      container: ContainerType.top,
    );
  }

  void toCreateNewSecretChat() {
    _add(
      widget: _featureProvider
          .newChatFeatureApi.createNewSecretChatScreenFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toContacts() {
    _add(
      widget:
          _featureProvider.contactsFeatureApi.contactsScreenFactory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toAddContact() {
    _showNotImplementedDialog();
  }

  @override
  void toFindPeopleNearby() {
    _showNotImplementedDialog();
  }

  @override
  void toInviteFriends() {
    _showNotImplementedDialog();
  }

  @override
  void toChatAdministration(int chatId) {
    _add(
      widget: _featureProvider
          .chatAdministrationFeatureApi.chatAdministrationScreenFactory
          .create(chatId),
      key: _keyGenerator.generateForChatAdministration(chatId),
      container: ContainerType.top,
    );
  }

  @override
  void toAddNewContact(int userId) {
    _add(
      widget: _featureProvider.newContactFeatureApi.newContactScreenFactory
          .create(userId),
      key: _keyGenerator.generateForNewContact(),
      container: ContainerType.top,
    );
  }

  @override
  void toChangeUsername() {
    _add(
      widget: _featureProvider
          .changeUsernameFeatureApi.changeUsernameScreenFactory
          .create(),
      key: _keyGenerator.generateForChangeUsername(),
      container: ContainerType.top,
    );
  }

  @override
  void toChangeBio() {
    _add(
      widget:
          _featureProvider.changeBioFeatureApi.changeBioScreenFactory.create(),
      key: _keyGenerator.generateForChangeBio(),
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
    LocalKey? key,
  }) {
    _navigationDelegate.add(
      key: key ?? UniqueKey(),
      builder: (_) => widget,
      container: container,
    );
  }

  @override
  void close() {
    throw Exception('not allowed here, you must implement router for screen');
  }
}
