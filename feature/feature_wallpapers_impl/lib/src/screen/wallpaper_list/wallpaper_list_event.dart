import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallpaper_list_event.freezed.dart';

@freezed
@immutable
class WallpaperListEvent with _$WallpaperListEvent {
  const factory WallpaperListEvent.init() = Init;
}
