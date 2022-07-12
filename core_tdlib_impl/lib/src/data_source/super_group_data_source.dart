import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class SuperGroupDataSource {
  SuperGroupDataSource({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  Future<td.Supergroup> getGroup(int id) =>
      _functionExecutor.send<td.Supergroup>(td.GetSupergroup(supergroupId: id));

  Future<td.SupergroupFullInfo> getGroupFullInfo(int id) => _functionExecutor
      .send<td.SupergroupFullInfo>(td.GetSupergroupFullInfo(supergroupId: id));
}
