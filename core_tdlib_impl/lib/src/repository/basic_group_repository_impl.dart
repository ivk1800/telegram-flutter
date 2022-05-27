import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:tdlib/td_api.dart' as td;

class BasicGroupRepositoryImpl extends IBasicGroupRepository {
  BasicGroupRepositoryImpl({
    required BasicGroupDataSource dataSource,
  }) : _dataSource = dataSource;

  final BasicGroupDataSource _dataSource;

  @override
  Future<td.BasicGroup> getGroup(int id) => _dataSource.getGroup(id);

  @override
  Future<td.BasicGroupFullInfo> getGroupFullInfo(int id) =>
      _dataSource.getGroupFullInfo(id);
}
