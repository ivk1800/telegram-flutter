import 'package:equatable/equatable.dart';

abstract class WallpaperListEvent extends Equatable {
  const WallpaperListEvent();

  @override
  List<Object> get props => <Object>[];
}

class InitEvent extends WallpaperListEvent {
  const InitEvent();
}
