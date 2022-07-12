import 'package:td_api/td_api.dart' as td;

abstract class IBasicGroupRepository {
  Future<td.BasicGroup> getGroup(int id);

  Future<td.BasicGroupFullInfo> getGroupFullInfo(int id);
}
