import 'dart:async';

import 'package:feature_file_api/feature_file_api.dart';

class FakeFileDownloader implements IFileDownloader {
  @override
  Future<void> downloadFile(int fileId) {
    return Completer<void>().future;
  }

  @override
  Future<IFileDownloadState> getFileDownloadState(int fileId) async {
    return const Downloading(progress: 0);
  }

  @override
  Stream<IFileDownloadState> getFileDownloadStateStream(int fileId) {
    return Stream<IFileDownloadState>.value(const Downloading(progress: 0));
  }
}
