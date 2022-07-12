import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:td_api/td_api.dart' as td;

class SuperGroupRepositoryImpl extends ISuperGroupRepository {
  SuperGroupRepositoryImpl({
    required SuperGroupDataSource dataSource,
  }) : _dataSource = dataSource;

  final SuperGroupDataSource _dataSource;

  @override
  Future<td.Supergroup> getGroup(int id) => _dataSource.getGroup(id);

  @override
  Future<td.SupergroupFullInfo> getGroupFullInfo(int id) =>
      _dataSource.getGroupFullInfo(id);
}
