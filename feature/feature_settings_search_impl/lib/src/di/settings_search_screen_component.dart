import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_page.dart';
import 'package:feature_settings_search_impl/src/settings_search_screen_router.dart';
import 'package:feature_settings_search_impl/src/tile/model/faq_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/widget/faq_result_tile_adapter_delegate.dart';
import 'package:feature_settings_search_impl/src/tile/widget/search_result_tile_adapter_delegate.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'settings_search_screen_component.jugger.dart';

@j.Component(modules: <Type>[SettingSearchModule])
abstract class SettingsSearchScreenComponent
    implements
        IWidgetStateComponent<SettingsSearchPage, SettingsSearchPageState> {
  @override
  void inject(SettingsSearchPageState screenState);
}

@j.module
abstract class SettingSearchModule {
  @j.provide
  @j.singleton
  static ILocalizationManager provideLocalizationManager(
          ISettingsSearchFeatureDependencies dependencies) =>
      dependencies.localizationManager;

  @j.provide
  @j.singleton
  static IConnectionStateUpdatesProvider provideConnectionStateUpdatesProvider(
          ISettingsSearchFeatureDependencies dependencies) =>
      dependencies.connectionStateUpdatesProvider;

  @j.provide
  @j.singleton
  static ISettingsSearchScreenRouter provideRouter(
          ISettingsSearchFeatureDependencies dependencies) =>
      dependencies.router;

  @j.provide
  @j.singleton
  static Map<Type, IListAdapterDelegate<ITileModel>>
      provideListAdapterDelegates(
    FaqResultTileAdapterDelegate faqResultTileAdapterDelegate,
    SearchResultTileAdapterDelegate searchResultTileAdapterDelegate,
  ) {
    return <Type, IListAdapterDelegate<ITileModel>>{
      FaqResultTileModel: faqResultTileAdapterDelegate,
      SearchResultTileModel: searchResultTileAdapterDelegate
    };
  }

  @j.provide
  @j.singleton
  static ListAdapter provideListAdapter(
          Map<Type, IListAdapterDelegate<ITileModel>> delegates) =>
      ListAdapter(delegates);

  // TODO replace by Bind
  @j.provide
  @j.singleton
  static IFaqResultTileListener provideFaqResultTileListener(
          SettingsSearchPageState state) =>
      state;

  @j.provide
  @j.singleton
  static ISearchResultTileListener provideSearchResultTileListener(
          SettingsSearchPageState state) =>
      state;
}

@j.componentBuilder
abstract class NameComponentBuilder {
  NameComponentBuilder screenState(SettingsSearchPageState screen);

  NameComponentBuilder dependencies(
      ISettingsSearchFeatureDependencies dependencies);

  SettingsSearchScreenComponent build();
}

extension NameComponentExt on SettingsSearchPage {
  Widget wrap(ISettingsSearchFeatureDependencies dependencies) =>
      ComponentHolder<SettingsSearchPage, SettingsSearchPageState>(
        componentFactory: (SettingsSearchPageState state) =>
            JuggerSettingsSearchScreenComponentBuilder()
                .dependencies(dependencies)
                .screenState(state)
                .build(),
        child: this,
      );
}
