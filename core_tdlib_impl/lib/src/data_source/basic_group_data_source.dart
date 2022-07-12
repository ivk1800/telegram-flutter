import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class BasicGroupDataSource {
  BasicGroupDataSource({
    required ITdFunctionExecutor functionExecutor,
  }) : _functionExecutor = functionExecutor;

  final ITdFunctionExecutor _functionExecutor;

  Future<td.BasicGroup> getGroup(int id) =>
      _functionExecutor.send<td.BasicGroup>(td.GetBasicGroup(basicGroupId: id));

  Future<td.BasicGroupFullInfo> getGroupFullInfo(int id) => _functionExecutor
      .send<td.BasicGroupFullInfo>(td.GetBasicGroupFullInfo(basicGroupId: id));
}
