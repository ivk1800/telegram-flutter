import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_download_state.freezed.dart';

@freezed
@immutable
class FileDownloadState with _$FileDownloadState {
  const factory FileDownloadState.none() = None;

  const factory FileDownloadState.downloading({
    required int progress,
  }) = Downloading;

  const factory FileDownloadState.completed({
    required String path,
  }) = Completed;
}
