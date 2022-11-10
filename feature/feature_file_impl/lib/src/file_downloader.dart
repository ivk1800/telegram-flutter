import 'dart:io';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;

class FileDownloader implements IFileDownloader {
  FileDownloader({
    required IFileRepository fileRepository,
    required ITdFunctionExecutor functionExecutor,
    required IFileUpdatesProvider fileUpdatesProvider,
  })  : _fileRepository = fileRepository,
        _functionExecutor = functionExecutor,
        _fileUpdatesProvider = fileUpdatesProvider;

  final IFileRepository _fileRepository;
  final IFileUpdatesProvider _fileUpdatesProvider;
  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<void> startDownloadFile(int fileId) {
    return _functionExecutor.send(
      td.DownloadFile(
        limit: 0,
        offset: 0,
        priority: 1,
        fileId: fileId,
        synchronous: false,
      ),
    );
  }

  @override
  Future<File> downloadFile(int fileId) {
    return _functionExecutor
        .send<td.File>(
      td.DownloadFile(
        limit: 0,
        offset: 0,
        priority: 1,
        fileId: fileId,
        synchronous: true,
      ),
    )
        .then((td.File value) {
      assert(value.local.isDownloadingCompleted);
      return File(value.local.path);
    });
  }

  @override
  Future<FileDownloadState> getFileDownloadState(int fileId) {
    return _fileRepository.getFile(fileId).then(_toDownloadState);
  }

  @override
  Stream<FileDownloadState> getFileDownloadStateStream(int fileId) {
    final Stream<FileDownloadState> currentState =
        Stream<FileDownloadState>.fromFuture(getFileDownloadState(fileId));
    final Stream<FileDownloadState> stateUpdates = _fileUpdatesProvider
        .fileUpdates
        .where((td.UpdateFile update) => update.file.id == fileId)
        .map((td.UpdateFile update) => _toDownloadState(update.file));
    return Rx.concat(<Stream<FileDownloadState>>[currentState, stateUpdates]);
  }

  FileDownloadState _toDownloadState(td.File file) {
    final td.LocalFile local = file.local;
    if (local.isDownloadingCompleted) {
      return FileDownloadState.completed(path: local.path);
    } else if (local.isDownloadingActive) {
      if (file.expectedSize > 0) {
        final double percent = local.downloadedSize / file.expectedSize * 100;
        return FileDownloadState.downloading(progress: percent.toInt());
      } else {
        return const FileDownloadState.downloading(progress: 0);
      }
    }
    return const FileDownloadState.none();
  }
}
