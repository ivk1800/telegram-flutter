import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_settings_search_impl/src/data/search_repository.dart';
import 'package:feature_settings_search_impl/src/domain/search_item_data.dart';
import 'package:feature_settings_search_impl/src/screen/search_item_listener.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_interactor.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_view_model.dart';
import 'package:feature_settings_search_impl/src/tile/search_result_tile_model_mapper.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:search_component/search_component.dart';
import 'package:tile/tile.dart';

@j.Component(
  modules: <Type>[SearchSettingsScreenModule],
)
abstract class ISearchSettingsScreenComponent {
  SettingsSearchViewModel getSettingsSearchViewModel();

  ILocalizationManager getLocalizationManager();

  IConnectionStateProvider getConnectionStateProvider();

  SearchItemListener getSearchItemListener();
}

@j.module
abstract class SearchSettingsScreenModule {
  @j.singleton
  @j.provides
  static SettingsSearchViewModel provideSettingsSearchViewModel(
    SettingsSearchInteractor searchInteractor,
    ISettingsSearchScreenRouter router,
  ) =>
      SettingsSearchViewModel(
        searchInteractor: searchInteractor,
        router: router,
      )..init();

  @j.singleton
  @j.provides
  static ISettingsSearchScreenRouter provideSettingsSearchScreenRouter(
    SettingsSearchFeatureDependencies dependencies,
  ) =>
      dependencies.router;

  @j.singleton
  @j.provides
  static ISearchInteractor<List<ITileModel>> provideSearchInteractor(
    SettingsSearchFeatureDependencies dependencies,
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
  static ILocalizationManager provideLocalizationManager(
    SettingsSearchFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;

  @j.singleton
  @j.provides
  static SearchRepository provideSearchRepository(
    ILocalizationManager localizationManager,
  ) =>
      SearchRepository(
        localizationManager: localizationManager,
      );

  @j.singleton
  @j.provides
  static IConnectionStateProvider provideConnectionStateProvider(
    SettingsSearchFeatureDependencies dependencies,
  ) =>
      dependencies.connectionStateProvider;

  @j.singleton
  @j.provides
  static SearchItemListener provideSearchItemListener(
    SettingsSearchViewModel viewModel,
  ) =>
      SearchItemListener(viewModel: viewModel);
}

@j.componentBuilder
abstract class ISearchSettingsScreenComponentBuilder {
  ISearchSettingsScreenComponentBuilder dependencies(
    SettingsSearchFeatureDependencies dependencies,
  );

  ISearchSettingsScreenComponent build();
}
