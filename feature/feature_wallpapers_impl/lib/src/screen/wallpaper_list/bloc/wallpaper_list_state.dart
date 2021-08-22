import 'package:coreui/coreui.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallpaper_list_state.freezed.dart';

@freezed
@immutable
class WallpaperListState with _$WallpaperListState {
  const factory WallpaperListState({
    required List<ITileModel> backgrounds,
  }) = Data;

  const factory WallpaperListState.loading() = Loading;
}
