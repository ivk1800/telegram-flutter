import 'package:td_api/td_api.dart' as td;

abstract class IFileUpdatesProvider {
  Stream<td.UpdateFile> get fileUpdates;
}
