import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

// todo move cache to another class
class FileDataSource {
  FileDataSource({
    required ITdFunctionExecutor functionExecutor,
    required IEventsProvider eventsProvider,
  })  : _functionExecutor = functionExecutor,
        _eventsProvider = eventsProvider {
    _init();
  }

  final ITdFunctionExecutor _functionExecutor;
  final IEventsProvider _eventsProvider;

  final Map<int, Future<td.LocalFile>> _cache = <int, Future<td.LocalFile>>{};
  final Map<int, String> _pathCache = <int, String>{};

  StreamSubscription<td.UpdateFile>? _fileUpdatesSubscription;

  Future<td.LocalFile> getLocalFile(int id) {
    return _cache.putIfAbsent(
      id,
      () => _functionExecutor
          .send<td.File>(td.GetFile(fileId: id))
          .then((td.File value) {
        if (value.local.isDownloadingCompleted) {
          _pathCache[id] = value.local.path;
          return Future<td.LocalFile>.value(value.local);
        }

        return _functionExecutor
            .send<td.File>(
          td.DownloadFile(
            fileId: id,
            priority: 1,
            limit: 0,
            offset: 0,
            synchronous: true,
          ),
        )
            .then((td.File value) {
          _pathCache[id] = value.local.path;
          return value.local;
        });
      }),
    );
  }

  String? getPathOrNull(int id) => _pathCache[id];

  Future<td.File> getFile(int id) =>
      _functionExecutor.send<td.File>(td.GetFile(fileId: id));

  void dispose() {
    _fileUpdatesSubscription?.cancel();
  }

  void _init() {
    _fileUpdatesSubscription = _eventsProvider.events
        .where((td.TdObject event) => event is td.UpdateFile)
        .map((td.TdObject event) => event as td.UpdateFile)
        .listen((td.UpdateFile event) {
      if (!event.file.local.isDownloadingCompleted &&
          event.file.local.path.isEmpty) {
        _cache.remove(event.file.id);
      }
    });
  }
}
