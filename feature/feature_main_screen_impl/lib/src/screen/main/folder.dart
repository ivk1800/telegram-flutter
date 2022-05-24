import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';

@freezed
@immutable
class Folder with _$Folder {
  const factory Folder.main() = MainFolder;

  const factory Folder.id({
    required int id,
    required String title,
  }) = IdFolder;
}
