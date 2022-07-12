import 'package:td_api/td_api.dart' as td;

abstract class IUserUpdatesProvider {
  Stream<td.UpdateUser> get userUpdates;
}
