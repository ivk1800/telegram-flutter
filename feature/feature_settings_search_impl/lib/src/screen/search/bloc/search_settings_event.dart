import 'package:equatable/equatable.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';

abstract class SearchSettingsEvent extends Equatable {
  const SearchSettingsEvent();

  @override
  List<Object> get props => <Object>[];
}

abstract class ActionEvent extends SearchSettingsEvent {
  const ActionEvent();
}

class SuggestTap extends ActionEvent {
  const SuggestTap();
}

class FaqResultTap extends ActionEvent {
  const FaqResultTap({required this.url});

  final String url;
}

class SearchResultTap extends ActionEvent {
  const SearchResultTap({required this.type});

  final SearchResultType type;
}
