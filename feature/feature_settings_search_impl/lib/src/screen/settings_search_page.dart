import 'package:coreui/coreui.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/widget/faq_result_tile_adapter_delegate.dart';
import 'package:feature_settings_search_impl/src/tile/widget/search_result_tile_adapter_delegate.dart';
import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'settings_search_view_model.dart';

class SettingsSearchPage extends StatefulWidget {
  const SettingsSearchPage({Key? key}) : super(key: key);

  @override
  SettingsSearchPageState createState() => SettingsSearchPageState();
}

class SettingsSearchPageState extends State<SettingsSearchPage>
    with
        TickerProviderStateMixin,
        StateInjectorMixin<SettingsSearchPage, SettingsSearchPageState>
    implements IFaqResultTileListener, ISearchResultTileListener {
  @j.inject
  late ILocalizationManager localizationManager;

  @j.inject
  late SettingsSearchViewModel viewModel;

  @j.inject
  late ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @j.inject
  late ListAdapter listAdapter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ITileModel>>(
      stream: viewModel.suggests,
      builder:
          (BuildContext context, AsyncSnapshot<List<ITileModel>> snapshot) {
        if (snapshot.hasData) {
          final List<ITileModel> items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final ITileModel tileModel = items[index];
              return listAdapter.create(context, tileModel);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void onFaqResultTap(String url) => viewModel.onFaqResultTap(url);

  @override
  void onSearchResultTap(SearchResultType type) =>
      viewModel.onSearchResultTap(type);
}
