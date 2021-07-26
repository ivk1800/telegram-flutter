import 'package:tdlib/td_api.dart' as td;

abstract class IBasicGroupRepository {
  Future<td.BasicGroup> getGroup(int id);

  Future<td.BasicGroupFullInfo> getGroupFullInfo(int id);
}
