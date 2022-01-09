import 'dart:async';

import 'package:feature_file_api/feature_file_api.dart';

class FakeFileDownloader implements IFileDownloader {
  @override
  Future<void> downloadFile(int fileId) {
    return Completer<void>().future;
  }

  @override
  Future<FileDownloadState> getFileDownloadState(int fileId) async {
    return const FileDownloadState.downloading(progress: 0);
  }

  @override
  Stream<FileDownloadState> getFileDownloadStateStream(int fileId) {
    return Stream<FileDownloadState>.value(
      const FileDownloadState.downloading(progress: 0),
    );
  }
}
