import 'package:coreui/coreui.dart' as tg;
import 'package:feature_privacy_settings_api/feature_privacy_settings_api.dart';
import 'package:feature_privacy_settings_impl/feature_privacy_settings_impl.dart';
import 'package:feature_privacy_settings_impl/src/screen/privacy_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class PrivacySettingsWidgetFactory implements IPrivacySettingsWidgetFactory {
  PrivacySettingsWidgetFactory({required this.dependencies});

  final PrivacySettingsFeatureDependencies dependencies;

  @override
  Widget create() => MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<ILocalizationManager>.value(
              value: dependencies.localizationManager),
          Provider<tg.ConnectionStateWidgetFactory>.value(
              value: tg.ConnectionStateWidgetFactory(
                  connectionStateProvider:
                      dependencies.connectionStateProvider))
        ],
        child: const PrivacySettingsPage(),
      );
}
