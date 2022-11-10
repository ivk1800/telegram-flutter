import 'dart:async';
import 'dart:io';

import 'package:feature_file_api/feature_file_api.dart';

class FakeFileDownloader implements IFileDownloader {
  const FakeFileDownloader({
    this.fileDownloadStateStreamProvider,
    this.downloadFileProvider,
  });

  final Stream<FileDownloadState>? Function(int fileId)?
      fileDownloadStateStreamProvider;
  final Future<File> Function(int fileId)? downloadFileProvider;

  @override
  Future<void> startDownloadFile(int fileId) {
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

  @override
  Future<File> downloadFile(int fileId) {
    final Future<File> Function(int fileId)? downloadFileProvider =
        this.downloadFileProvider;
    if (downloadFileProvider != null) {
      return downloadFileProvider.call(fileId);
    }
    throw UnimplementedError();
  }
}
