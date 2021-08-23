import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';
import 'package:tile/tile.dart';

import 'search/bloc/search_settings_bloc.dart';
import 'search/bloc/search_settings_state.dart';

class SettingsSearchPage extends StatelessWidget {
  const SettingsSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = Provider.of(context);
    final TileFactory tileFactory = Provider.of(context);
    return BlocBuilder<SearchSettingsBloc, SearchSettingsState>(
        builder: (BuildContext context, SearchSettingsState state) {
      switch (state.runtimeType) {
        case DefaultState:
          {
            final List<ITileModel> items = (state as DefaultState).tileModels;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final ITileModel tileModel = items[index];
                return tileFactory.create(context, tileModel);
              },
            );
          }
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
//
// class SettingsSearchPageState extends State<SettingsSearchPage>
//     with
//         TickerProviderStateMixin,
//         StateInjectorMixin<SettingsSearchPage, SettingsSearchPageState>
//     implements IFaqResultTileListener, ISearchResultTileListener {
//   @j.inject
//   late ILocalizationManager localizationManager;
//
//   @j.inject
//   late SettingsSearchViewModel viewModel;
//
//   @j.inject
//   late ConnectionStateWidgetFactory connectionStateWidgetFactory;
//
//   @j.inject
//   late TileFactory tileFactory;
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<ITileModel>>(
//       stream: viewModel.suggests,
//       builder:
//           (BuildContext context, AsyncSnapshot<List<ITileModel>> snapshot) {
//         if (snapshot.hasData) {
//           final List<ITileModel> items = snapshot.data!;
//           return ListView.builder(
//             itemCount: items.length,
//             itemBuilder: (BuildContext context, int index) {
//               final ITileModel tileModel = items[index];
//               return tileFactory.create(context, tileModel);
//             },
//           );
//         }
//         return const Center(child: CircularProgressIndicator());
//       },
//     );
//   }
//
//   @override
//   void onFaqResultTap(String url) => viewModel.onFaqResultTap(url);
//
//   @override
//   void onSearchResultTap(SearchResultType type) =>
//       viewModel.onSearchResultTap(type);
// }
