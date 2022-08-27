import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_screen_scope_delegate.scope.dart';
import 'package:flutter/material.dart';
import 'package:tile/tile.dart';

import 'search_state.dart';
import 'settings_search_view_model.dart';

class SettingsSearchPage extends StatefulWidget {
  const SettingsSearchPage({
    super.key,
    required this.controller,
  });

  final SettingsSearchScreenController controller;

  @override
  State<SettingsSearchPage> createState() => _SettingsSearchPageState();
}

class _SettingsSearchPageState extends State<SettingsSearchPage> {
  @override
  void initState() {
    _listenController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SettingsSearchViewModel viewModel =
        SettingsSearchScreenScope.getSettingsSearchViewModel(context);

    return StreamListener<SearchState>(
      stream: viewModel.state,
      builder: (BuildContext context, SearchState state) {
        return state.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          empty: () {
            return const Center(
              child: Text('empty'),
            );
          },
          data: (List<ITileModel> models) {
            final TileFactory tileFactory =
                SettingsSearchScreenScope.getTileFactory(context);

            return ListView.builder(
              itemCount: models.length,
              itemBuilder: (BuildContext context, int index) {
                final ITileModel tileModel = models[index];
                return tileFactory.create(context, tileModel);
              },
            );
          },
        );
      },
    );
  }

  void onCallback() {
    final String query = widget.controller.queryValue.value;
    SettingsSearchScreenScope.getSettingsSearchViewModel(context)
        .onQueryChanged(query);
  }

  @override
  void didUpdateWidget(covariant SettingsSearchPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.queryValue.removeListener(onCallback);
      _listenController();
    }
  }

  @override
  void dispose() {
    widget.controller.queryValue.removeListener(onCallback);
    super.dispose();
  }

  void _listenController() {
    widget.controller.queryValue.addListener(onCallback);
  }
}
