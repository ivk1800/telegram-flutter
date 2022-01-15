import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_settings_search_impl/src/di/search_settings_screen_component.dart';
import 'package:feature_settings_search_impl/src/di/search_settings_screen_component.jugger.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_page.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_view_model.dart';
import 'package:feature_settings_search_impl/src/tile/delegate/faq_result_tile_factory_delegate.dart';
import 'package:feature_settings_search_impl/src/tile/delegate/search_result_tile_factory_delegate.dart';
import 'package:feature_settings_search_impl/src/tile/model/faq_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';
import 'package:tile/tile.dart';

class SearchSettingsScreenFactory implements ISettingsSearchScreenFactory {
  SearchSettingsScreenFactory({
    required SettingsSearchFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SettingsSearchFeatureDependencies _dependencies;

  @override
  Widget create(
    SettingsSearchScreenController controller,
  ) =>
      Scope<ISearchSettingsScreenComponent>(
        create: () => JuggerSearchSettingsScreenComponentBuilder()
            .dependencies(_dependencies)
            .build(),
        providers: (ISearchSettingsScreenComponent component) {
          return <Provider<dynamic>>[
            Provider<SettingsSearchViewModel>.value(
              value: component.getSettingsSearchViewModel(),
            ),
            Provider<ILocalizationManager>.value(
              value: component.getLocalizationManager(),
            ),
            Provider<TileFactory>.value(
              value: TileFactory(
                delegates: <Type, ITileFactoryDelegate<ITileModel>>{
                  FaqResultTileModel: FaqResultTileFactoryDelegate(
                    listener: component.getSearchItemListener(),
                  ),
                  SearchResultTileModel: SearchResultTileFactoryDelegate(
                    listener: component.getSearchItemListener(),
                  ),
                },
              ),
            ),
            Provider<ConnectionStateWidgetFactory>.value(
              value: ConnectionStateWidgetFactory(
                connectionStateProvider: component.getConnectionStateProvider(),
              ),
            ),
          ];
        },
        child: SettingsSearchPage(controller: controller),
      );
}
