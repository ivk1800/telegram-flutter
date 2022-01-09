library feature_file_api;

import 'src/file_download_state.dart';

export 'src/file_download_state.dart';

abstract class IFileFeatureApi {
  IFileDownloader get fileDownloader;
}

abstract class IFileDownloader {
  Future<FileDownloadState> getFileDownloadState(int fileId);

  Stream<FileDownloadState> getFileDownloadStateStream(int fileId);

  Future<void> downloadFile(int fileId);
}
