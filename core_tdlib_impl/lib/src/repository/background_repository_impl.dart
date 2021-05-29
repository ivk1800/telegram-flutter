import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:td_client/td_client.dart';
import 'package:jugger/jugger.dart' as j;

class BackgroundRepositoryImpl implements IBackgroundRepository {
  @j.inject
  BackgroundRepositoryImpl(this._client);

  final TdClient _client;

  @override
  Future<List<td.Background>> get backgrounds => _client
      .send<td.Backgrounds>(td.GetBackgrounds(forDarkTheme: false))
      .then((td.Backgrounds value) => value.backgrounds);
}
