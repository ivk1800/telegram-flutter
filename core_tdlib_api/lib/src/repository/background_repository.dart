import 'package:td_api/td_api.dart' as td;

abstract class IBackgroundRepository {
  Future<List<td.Background>> get backgrounds;
}
