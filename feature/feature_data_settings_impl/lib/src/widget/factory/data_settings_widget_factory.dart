import 'package:coreui/coreui.dart';
import 'package:feature_data_settings_api/feature_data_settings_api.dart';
import 'package:feature_data_settings_impl/feature_data_settings_impl.dart';
import 'package:feature_data_settings_impl/src/screen/data_settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class DataSettingsWidgetFactory implements IDataSettingsWidgetFactory {
  DataSettingsWidgetFactory({required this.dependencies});

  final DataSettingsFeatureDependencies dependencies;

  @override
  Widget create() => MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<ILocalizationManager>.value(
            value: dependencies.localizationManager,
          ),
          Provider<ConnectionStateWidgetFactory>.value(
            value: ConnectionStateWidgetFactory(
              connectionStateProvider: dependencies.connectionStateProvider,
            ),
          ),
        ],
        child: const DataSettingsPage(),
      );
}
