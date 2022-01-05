import 'package:feature_notifications_settings_api/feature_notifications_settings_api.dart';
import 'package:feature_notifications_settings_impl/feature_notifications_settings_impl.dart';
import 'package:feature_notifications_settings_impl/src/screen/quick_notification_settings/quick_notification_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class QuickNotificationSettingsScreenFactory
    implements IQuickNotificationSettingsScreenFactory {
  QuickNotificationSettingsScreenFactory({
    required NotificationsSettingsFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final NotificationsSettingsFeatureDependencies _dependencies;

  @override
  Widget create() {
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<ILocalizationManager>.value(
          value: _dependencies.localizationManager,
        ),
      ],
      child: const QuickNotificationSettingsPage(),
    );
  }
}
