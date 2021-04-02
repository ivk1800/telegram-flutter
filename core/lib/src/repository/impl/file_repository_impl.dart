import 'package:core/src/repository/repository.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class FileRepositoryImpl implements IFileRepository {
  @j.inject
  FileRepositoryImpl(this._client) {
    _client.events
        .where((td.TdObject event) => event is td.UpdateFile)
        .map((td.TdObject event) => event as td.UpdateFile)
        .listen((td.UpdateFile event) {
      if (!event.file.local.isDownloadingCompleted &&
          event.file.local.path.isEmpty) {
        _cache.remove(event.file.id);
      }
    });
  }

  final TdClient _client;

  final Map<int, Future<td.LocalFile>> _cache = <int, Future<td.LocalFile>>{};

  @override
  Future<td.LocalFile> getLocalFile(int id) {
    return _cache.putIfAbsent(
        id,
        () =>
            _client.send<td.File>(td.GetFile(fileId: id)).then((td.File value) {
              if (value.local.isDownloadingCompleted) {
                return Future<td.LocalFile>.value(value.local);
              }

              return _client
                  .send<td.File>(td.DownloadFile(
                      fileId: id,
                      priority: 1,
                      limit: 0,
                      offset: 0,
                      synchronous: true))
                  .then((td.File value) {
                return value.local;
              });
            }));
  }
}
