import 'package:feature_settings_search_impl/src/domain/search_item.dart';
import 'package:feature_settings_search_impl/src/screen/settings_search_view_model.dart';
import 'package:feature_settings_search_impl/src/tile/delegate/faq_result_tile_factory_delegate.dart';
import 'package:feature_settings_search_impl/src/tile/delegate/search_result_tile_factory_delegate.dart';

class SearchItemListener
    implements IFaqResultTapListener, ISearchResultTapListener {
  SearchItemListener({
    required SettingsSearchViewModel viewModel,
  }) : _viewModel = viewModel;

  final SettingsSearchViewModel _viewModel;

  @override
  void onFaqResultTap(String url) => _viewModel.onFaqResultTap(url);

  @override
  void onSearchResultTap(SearchItem item) => _viewModel.onSearchResultTap(item);
}
