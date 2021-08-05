import 'package:dialog_api/dialog_api.dart';
import 'package:dialog_api/dialog_api.dart' as dialog_api;
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_profile_api/feature_profile_api.dart';
import 'package:feature_profile_impl/feature_profile_impl.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/feature/feature.dart';
import 'package:split_view/split_view.dart';

import 'navigation.dart';

class CommonScreenRouterImpl
    implements IChatScreenRouter, IProfileFeatureRouter, IDialogRouter {
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

  @override
  void toChat(int id) {}

  @override
  void toChatProfile(int chatId) {
    final IProfileScreenFactory factory =
        _featureFactory.createProfileFeatureApi().profileScreenFactory;
    _navigationRouter.push(
        key: UniqueKey(),
        builder: (BuildContext context) => factory.create(context, chatId),
        container: ContainerType.Top);
  }

  @override
  void toSharedMedia(SharedContentType type) {
    final ISharedMediaScreenFactory factory =
        _featureFactory.createSharedMediaFeatureApi().sharedMediaScreenFactory;
    _navigationRouter.push(
        key: UniqueKey(),
        builder: (BuildContext context) => factory.create(context, type),
        container: ContainerType.Top);
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
  void toDialog(
      {String? title,
      required Body body,
      List<dialog_api.Action> actions = const <dialog_api.Action>[]}) {
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
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: createContent(),
          actions: actions
              .map((dialog_api.Action action) => TextButton(
                    child: Text(action.text),
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
}
