import 'dart:io';

import 'file_download_state.dart';

abstract class IFileDownloader {
  Future<FileDownloadState> getFileDownloadState(int fileId);

  Stream<FileDownloadState> getFileDownloadStateStream(int fileId);

  Future<void> startDownloadFile(int fileId);

  Future<File> downloadFile(int fileId);
}
