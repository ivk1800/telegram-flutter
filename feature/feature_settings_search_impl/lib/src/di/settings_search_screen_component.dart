import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_impl/src/data/search_repository.dart';
import 'package:feature_settings_search_impl/src/domain/search_item_data.dart';
import 'package:feature_settings_search_impl/src/screen/search_item_listener.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_screen_scope_delegate.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_view_model.dart';
import 'package:feature_settings_search_impl/src/settings_search_feature_dependencies.dmg.dart';
import 'package:feature_settings_search_impl/src/tile/delegate/faq_result_tile_factory_delegate.dart';
import 'package:feature_settings_search_impl/src/tile/delegate/search_result_tile_factory_delegate.dart';
import 'package:feature_settings_search_impl/src/tile/model/faq_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/search_result_tile_model_mapper.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:search_component/search_component.dart';
import 'package:tile/tile.dart';

import 'search_settings_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    SettingsSearchScreenModule,
    SettingsSearchFeatureDependenciesModule,
  ],
  builder: ISearchSettingsScreenComponentBuilder,
)
@j.singleton
abstract class ISettingsSearchScreenComponent
    implements ISettingsSearchScreenScopeDelegate {}

@j.module
abstract class SettingsSearchScreenModule {
  @j.singleton
  @j.provides
  static TileFactory provideTileFactory(
    ISearchResultTapListener resultTapListener,
    IFaqResultTapListener faqResultTapListener,
  ) =>
      TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          FaqResultTileModel: FaqResultTileFactoryDelegate(
            listener: faqResultTapListener,
          ),
          SearchResultTileModel: SearchResultTileFactoryDelegate(
            listener: resultTapListener,
          ),
        },
      );

  @j.singleton
  @j.provides
  static ISearchInteractor<List<ITileModel>> provideSearchInteractor(
    SearchRepository searchRepository,
    SearchResultTileModelMapper mapper,
  ) =>
      ISearchInteractor.create<List<SearchItemData>, List<ITileModel>>(
        resultMapper: (List<SearchItemData> result) async {
          return result.map(mapper.mapToTileModel).toList();
        },
        resultFetcher: (String query) async {
          return searchRepository.find(query);
        },
        emptyTest: (List<SearchItemData> value) => value.isEmpty,
      );

  @j.singleton
  @j.provides
  static ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    IConnectionStateProvider connectionStateProvider,
  ) =>
      ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      );

  @j.singleton
  @j.provides
  static SearchRepository provideSearchRepository(
    IStringsProvider stringsProvider,
  ) =>
      SearchRepository(stringsProvider: stringsProvider);

  @j.singleton
  @j.provides
  static SearchItemListener provideSearchItemListener(
    SettingsSearchViewModel viewModel,
  ) =>
      SearchItemListener(viewModel: viewModel);

  @j.singleton
  @j.binds
  IFaqResultTapListener bindsFaqResultTapListener(SearchItemListener impl);

  @j.singleton
  @j.binds
  ISearchResultTapListener bindsSearchResultTapListener(
    SearchItemListener impl,
  );
}
