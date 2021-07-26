import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class SuperGroupRepositoryImpl extends ISuperGroupRepository {
  @j.inject
  SuperGroupRepositoryImpl(this._client);

  final TdClient _client;

  @override
  Future<td.Supergroup> getGroup(int id) =>
      _client.send<td.Supergroup>(td.GetSupergroup(supergroupId: id));

  @override
  Future<td.SupergroupFullInfo> getGroupFullInfo(int id) => _client
      .send<td.SupergroupFullInfo>(td.GetSupergroupFullInfo(supergroupId: id));
}
