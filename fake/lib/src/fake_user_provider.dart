import 'package:fake/src/utils.dart';
import 'package:td_api/td_api.dart' as td;

class FakeUserProvider {
  const FakeUserProvider();

  Future<td.User> getFakeUser() async => getUser('user_1');
}
