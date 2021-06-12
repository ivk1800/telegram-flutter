import 'package:coreui/coreui.dart' as tg;
import 'package:equatable/equatable.dart';

abstract class SearchSettingsState extends Equatable {
  const SearchSettingsState();

  @override
  List<Object> get props => <Object>[];
}

class DefaultState extends SearchSettingsState {
  const DefaultState({required this.tileModels});

  final List<tg.ITileModel> tileModels;
}
