import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeFileRepository implements IFileRepository {
  const FakeFileRepository();

  @override
  Future<td.LocalFile> getLocalFile(int id) {
    final Completer<td.LocalFile> completer = Completer<td.LocalFile>();
    return completer.future;
  }

  @override
  String? getPathOrNull(int id) => null;

  @override
  Future<td.File> getFile(int id) {
    final Completer<td.File> completer = Completer<td.File>();
    return completer.future;
  }
}
