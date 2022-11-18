import 'package:td_api/td_api.dart' as td;

abstract class IBackgroundRepository {
  Future<List<td.Background>> get backgrounds;

  Future<td.Background> getBackground(int id);
}
