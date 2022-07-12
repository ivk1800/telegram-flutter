import 'package:feature_sessions_impl/src/screen/sessions/tile/session_tile_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_api/td_api.dart' as td;
import 'package:tile/tile.dart';

class SessionTileMapper {
  @j.inject
  SessionTileMapper();

  ITileModel mapToTileModel(td.Session session) {
    return SessionTileModel(
      id: session.id,
      isCurrent: session.isCurrent,
      title: '${session.applicationName} ${session.applicationVersion}',
      subtitle:
          '${session.deviceModel}, ${session.platform} ${session.systemVersion}, (${session.apiId}) \n${session.ip} - ${session.country}',
    );
  }
}
