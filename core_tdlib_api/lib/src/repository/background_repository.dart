import 'package:tdlib/td_api.dart' as td;

abstract class IBackgroundRepository {
  Future<List<td.Background>> get backgrounds;
}
