import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:td_api/td_api.dart' as td;

class FileRepositoryImpl implements IFileRepository {
  FileRepositoryImpl({
    required FileDataSource dataSource,
  }) : _dataSource = dataSource;

  final FileDataSource _dataSource;

  @override
  Future<td.LocalFile> getLocalFile(int id) => _dataSource.getLocalFile(id);

  @override
  String? getPathOrNull(int id) => _dataSource.getPathOrNull(id);

  @override
  Future<td.File> getFile(int id) => _dataSource.getFile(id);

  void dispose() {
    _dataSource.dispose();
  }
}
