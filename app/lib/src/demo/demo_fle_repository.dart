import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:core/core.dart';

class DemoFileRepository implements IFileRepository {
  @override
  Future<td.LocalFile> getLocalFile(int id) {
    return Future<td.LocalFile>.error("not impelmented");
  }

  @override
  String? getPathOrNull(int id) {
    return null;
  }
}
