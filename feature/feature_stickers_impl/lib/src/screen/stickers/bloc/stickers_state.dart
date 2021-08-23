import 'package:equatable/equatable.dart';
import 'package:tile/tile.dart';

abstract class StickersState extends Equatable {
  const StickersState();

  @override
  List<Object> get props => <Object>[];
}

class DefaultState extends StickersState {
  const DefaultState({required this.tiles});

  final List<ITileModel> tiles;

  @override
  List<Object> get props => <Object>[tiles];
}
