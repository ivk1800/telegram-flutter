import 'dart:async';

import 'package:feature_file_api/feature_file_api.dart';

class FakeFileDownloader implements IFileDownloader {
  const FakeFileDownloader({
    this.fileDownloadStateStreamProvider,
  });

  final Stream<FileDownloadState>? Function(int fileId)?
      fileDownloadStateStreamProvider;

  @override
  Future<void> downloadFile(int fileId) {
    final Completer<void> completer = Completer<void>()..complete(null);
    return completer.future;
  }

  @override
  Future<FileDownloadState> getFileDownloadState(int fileId) async {
    return const FileDownloadState.downloading(progress: 0);
  }

  @override
  Stream<FileDownloadState> getFileDownloadStateStream(int fileId) {
    return fileDownloadStateStreamProvider?.call(fileId) ??
        Stream<FileDownloadState>.value(
          const FileDownloadState.downloading(progress: 0),
        );
  }
}
