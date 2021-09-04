import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_settings_search_impl/src/screen/search/bloc/search_settings_bloc.dart';
import 'package:feature_settings_search_impl/src/screen/search/bloc/search_settings_event.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_page.dart';
import 'package:feature_settings_search_impl/src/tile/model/faq_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/widget/faq_result_tile_factory_delegate.dart';
import 'package:feature_settings_search_impl/src/tile/widget/search_result_tile_factory_delegate.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

class SearchSettingsWidgetFactory implements ISettingsSearchWidgetFactory {
  SearchSettingsWidgetFactory({required this.dependencies});

  final SettingsSearchFeatureDependencies dependencies;

  @override
  Widget create() => MultiProvider(
        providers: <Provider<dynamic>>[
          Provider<ILocalizationManager>.value(
            value: dependencies.localizationManager,
          ),
          Provider<TileFactory>.value(
            value:
                TileFactory(delegates: <Type, ITileFactoryDelegate<ITileModel>>{
              FaqResultTileModel: FaqResultTileFactoryDelegate(
                tap: (BuildContext context, String url) {
                  BlocProvider.of<SearchSettingsBloc>(context)
                      .add(FaqResultTap(url: url));
                },
              ),
              SearchResultTileModel: SearchResultTileFactoryDelegate(
                tap: (BuildContext context, SearchResultType type) {
                  BlocProvider.of<SearchSettingsBloc>(context)
                      .add(SearchResultTap(type: type));
                },
              ),
            }),
          ),
          Provider<ConnectionStateWidgetFactory>.value(
            value: ConnectionStateWidgetFactory(
              connectionStateProvider: dependencies.connectionStateProvider,
            ),
          ),
        ],
        child: BlocProvider<SearchSettingsBloc>(
          create: (BuildContext context) => SearchSettingsBloc(
            router: dependencies.router,
          ),
          child: const SettingsSearchPage(),
        ),
      );
}
