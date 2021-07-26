import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class BasicGroupRepositoryImpl extends IBasicGroupRepository {
  @j.inject
  BasicGroupRepositoryImpl(this._client);

  final TdClient _client;

  @override
  Future<td.BasicGroup> getGroup(int id) =>
      _client.send<td.BasicGroup>(td.GetBasicGroup(basicGroupId: id));

  @override
  Future<td.BasicGroupFullInfo> getGroupFullInfo(int id) => _client
      .send<td.BasicGroupFullInfo>(td.GetBasicGroupFullInfo(basicGroupId: id));
}
