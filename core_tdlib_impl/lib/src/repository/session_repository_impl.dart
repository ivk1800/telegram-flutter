import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:td_api/td_api.dart' as td;

class SessionRepositoryImpl implements ISessionRepository {
  SessionRepositoryImpl({
    required SessionDataSource dataSource,
  }) : _dataSource = dataSource;

  final SessionDataSource _dataSource;

  @override
  Future<List<td.Session>> get activeSessions => _dataSource.activeSessions;
}
