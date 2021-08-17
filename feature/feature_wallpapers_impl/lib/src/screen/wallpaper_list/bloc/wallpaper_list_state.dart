import 'package:coreui/coreui.dart';
import 'package:equatable/equatable.dart';

abstract class WallpaperListState extends Equatable {
  const WallpaperListState();

  @override
  List<Object> get props => <Object>[];
}

class LoadingState extends WallpaperListState {
  const LoadingState();
}

class WallpapersState extends WallpaperListState {
  const WallpapersState({required this.backgrounds});

  final List<ITileModel> backgrounds;

  @override
  List<Object> get props => <Object>[backgrounds];
}
