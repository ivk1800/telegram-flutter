import 'package:td_api/td_api.dart' as td;

abstract class IFileRepository {
  Future<td.LocalFile> getLocalFile(int id);

  Future<td.File> getFile(int id);

  String? getPathOrNull(int id);
}
