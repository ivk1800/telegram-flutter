import 'package:equatable/equatable.dart';
import 'package:tile/tile.dart';

abstract class SearchSettingsState extends Equatable {
  const SearchSettingsState();

  @override
  List<Object> get props => <Object>[];
}

class DefaultState extends SearchSettingsState {
  const DefaultState({required this.tileModels});

  final List<ITileModel> tileModels;
}
