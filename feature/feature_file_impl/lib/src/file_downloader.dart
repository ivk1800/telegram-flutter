import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:rxdart/rxdart.dart';

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
  Future<void> downloadFile(int fileId) {
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
  Future<IFileDownloadState> getFileDownloadState(int fileId) {
    return _fileRepository.getFile(fileId).then(_toDownloadState);
  }

  @override
  Stream<IFileDownloadState> getFileDownloadStateStream(int fileId) {
    final Stream<IFileDownloadState> currentState =
        Stream<IFileDownloadState>.fromFuture(getFileDownloadState(fileId));
    final Stream<IFileDownloadState> stateUpdates = _fileUpdatesProvider
        .fileUpdates
        .where((td.UpdateFile update) => update.file.id == fileId)
        .map((td.UpdateFile update) => _toDownloadState(update.file));
    return Rx.concat(<Stream<IFileDownloadState>>[currentState, stateUpdates]);
  }

  IFileDownloadState _toDownloadState(td.File file) {
    final td.LocalFile local = file.local;
    if (local.isDownloadingCompleted) {
      return Completed(path: local.path);
    } else if (local.isDownloadingActive) {
      final double percent = local.downloadedSize / file.expectedSize * 100;
      return Downloading(progress: percent.toInt());
    }
    return const None();
  }
}
