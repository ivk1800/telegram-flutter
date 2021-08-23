import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;

class BasicGroupRepositoryImpl extends IBasicGroupRepository {
  BasicGroupRepositoryImpl({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  @override
  Future<td.BasicGroup> getGroup(int id) =>
      _functionExecutor.send<td.BasicGroup>(td.GetBasicGroup(basicGroupId: id));

  @override
  Future<td.BasicGroupFullInfo> getGroupFullInfo(int id) => _functionExecutor
      .send<td.BasicGroupFullInfo>(td.GetBasicGroupFullInfo(basicGroupId: id));
}
