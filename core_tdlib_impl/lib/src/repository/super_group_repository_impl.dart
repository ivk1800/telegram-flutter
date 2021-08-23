import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class SuperGroupRepositoryImpl extends ISuperGroupRepository {
  SuperGroupRepositoryImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<td.Supergroup> getGroup(int id) =>
      _functionExecutor.send<td.Supergroup>(td.GetSupergroup(supergroupId: id));

  @override
  Future<td.SupergroupFullInfo> getGroupFullInfo(int id) => _functionExecutor
      .send<td.SupergroupFullInfo>(td.GetSupergroupFullInfo(supergroupId: id));
}
