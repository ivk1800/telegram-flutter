import 'package:tdlib/td_api.dart' as td;

abstract class IFileRepository {
  Future<td.LocalFile> getLocalFile(int id);
}
