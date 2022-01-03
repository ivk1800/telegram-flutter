import 'package:app/src/feature/feature.dart';
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

import 'navigation.dart';

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
    required SplitNavigationRouter navigationRouter,
    required GlobalKey<NavigatorState> dialogNavigatorKey,
    required FeatureFactory featureFactory,
  })  : _navigationRouter = navigationRouter,
        _dialogNavigatorKey = dialogNavigatorKey,
        _featureFactory = featureFactory;

  final SplitNavigationRouter _navigationRouter;
  final FeatureFactory _featureFactory;
  final GlobalKey<NavigatorState> _dialogNavigatorKey;

  // TODO extract chat router delegate
  @override
  void toChat(int id) {
    final IChatScreenFactory factory =
        _featureFactory.createChatFeatureApi().chatScreenFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(context, id),
      container: ContainerType.right,
    );
  }

  @override
  void toChatProfile(int chatId) {
    final IProfileScreenFactory factory =
        _featureFactory.createProfileFeatureApi().profileScreenFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(context, chatId),
      container: ContainerType.top,
    );
  }

  @override
  void toSharedMedia(SharedContentType type) {
    final ISharedMediaScreenFactory factory =
        _featureFactory.createSharedMediaFeatureApi().sharedMediaScreenFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(context, type),
      container: ContainerType.top,
    );
  }

  @override
  void toQuickNotificationSettings() {
    final IQuickNotificationSettingsScreenFactory factory = _featureFactory
        .createNotificationsSettingsFeatureApi()
        .quickNotificationSettingsScreenFactory;
    _showDialog(
      builder: (BuildContext context) => factory.create(context: context),
    );
  }

  @override
  void toChooseCountry(void Function(Country country) callback) {
    final IChooseCountryScreenFactory factory =
        _featureFactory.createCountryFeatureApi().chooseCountryScreenFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(context, callback),
      container: ContainerType.top,
    );
  }

  @override
  void toDialog({
    String? title,
    required Body body,
    List<dialog_api.Action> actions = const <dialog_api.Action>[],
  }) {
    Widget? createContent() {
      switch (body.runtimeType) {
        case TextBody:
          {
            return Text((body as TextBody).text);
          }
      }

      return null;
    }

    _showDialog(
      builder: (BuildContext context) {
        Color? getActionColor(dialog_api.ActionType type) {
          switch (type) {
            case dialog_api.ActionType.simple:
              return null;
            case dialog_api.ActionType.attention:
              return Theme.of(context).errorColor;
          }
        }

        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: createContent(),
          actions: actions
              .map((dialog_api.Action action) => TextButton(
                    child: Text(
                      action.text,
                      style: TextStyle(color: getActionColor(action.type)),
                    ),
                    onPressed: () {
                      if (action.callback == null) {
                        Navigator.of(context).pop();
                      } else {
                        if (action.callback!.call()) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ))
              .toList(),
        );
      },
    );
  }

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
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createStickersFeatureApi()
          .archivedStickersWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toMasks() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createStickersFeatureApi()
          .masksWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toStickerSet(int setId) {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createStickersFeatureApi()
          .stickerSetWidgetFactory
          .create(setId),
      container: ContainerType.top,
    );
  }

  @override
  void toTrendingStickers() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createStickersFeatureApi()
          .trendingStickersWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toFolders() {
    final Widget foldersScreen =
        _featureFactory.createFoldersFeatureApi().foldersScreenFactory.create();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => foldersScreen,
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewFolder() {
    final Widget setupFolderScreen = _featureFactory
        .createFoldersFeatureApi()
        .setupFolderScreenFactory
        .create();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => setupFolderScreen,
      container: ContainerType.top,
    );
  }

  @override
  void toSessions() {
    final Widget screen = _featureFactory
        .createSessionsFeatureApi()
        .sessionsScreenFactory
        .create();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => screen,
      container: ContainerType.top,
    );
  }

  @override
  void toPrivacySettings() {
    final IPrivacySettingsWidgetFactory factory =
        _featureFactory.createPrivacySettingsFeatureApi().screenWidgetFactory;

    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toNotificationsSettings() {
    final INotificationsSettingsWidgetFactory factory = _featureFactory
        .createNotificationsSettingsFeatureApi()
        .screenWidgetFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toDataSettings() {
    final IDataSettingsWidgetFactory factory =
        _featureFactory.createDataSettingsFeatureApi().screenWidgetFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toChatSettings() {
    final IChatSettingsWidgetFactory factory =
        _featureFactory.createChatSettingsFeatureApi().screenWidgetFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toLogOut() {
    final ILogoutScreenFactory factory =
        _featureFactory.createLogoutFeatureApi().logoutScreenFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: factory.create,
      container: ContainerType.top,
    );
  }

  @override
  void toStickersAndMasks() {
    final IStickersWidgetFactory factory =
        _featureFactory.createStickersFeatureApi().stickersWidgetFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toWallPapers() {
    final IWallpapersListScreenFactory factory = _featureFactory
        .createWallpapersFeatureApi()
        .wallpapersListScreenFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: factory.create,
      container: ContainerType.top,
    );
  }

  @override
  void toEventsList() {
    final DevFeature feature = _featureFactory.createDevFeature();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => feature.createEventsListWidget(),
      container: ContainerType.top,
    );
  }

  @override
  void toSettings() {
    final ISettingScreenFactory factory =
        _featureFactory.createSettingsFeatureApi().settingsScreenFactory;
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => factory.create(),
      container: ContainerType.top,
    );
  }

  @override
  void toDev() {
    final DevFeature feature = _featureFactory.createDevFeature();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => feature.createRootWidget(),
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewChat() {
    final INewChatScreenFactory factory =
        _featureFactory.createCreateNewChatFeatureApi().newChatScreenFactory;
    final Widget widget = factory.create();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => widget,
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewChannel() {
    final ICreateNewChannelScreenFactory factory = _featureFactory
        .createCreateNewChatFeatureApi()
        .createNewChannelScreenFactory;
    final Widget widget = factory.create();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => widget,
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewGroup() {
    final ICreateNewGroupScreenFactory factory = _featureFactory
        .createCreateNewChatFeatureApi()
        .createNewGroupScreenFactory;
    final Widget widget = factory.create();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => widget,
      container: ContainerType.top,
    );
  }

  @override
  void toCreateNewSecretChat() {
    final ICreateNewSecretChatScreenFactory factory = _featureFactory
        .createCreateNewChatFeatureApi()
        .createNewSecretChatScreenFactory;
    final Widget widget = factory.create();
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => widget,
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
    toDialog(body: TextBody(text: 'not implemented'));
  }

  @override
  void back() {
    _navigationRouter.back();
  }
}
