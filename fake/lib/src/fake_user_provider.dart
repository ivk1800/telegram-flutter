import 'package:fake/src/utils.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeUserProvider {
  Future<td.User> getFakeUser() async => getUser('user_1');
}
