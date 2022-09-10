import 'package:jugger/jugger.dart' as j;
import 'package:td_client/td_client.dart';

class TdLibInitializer {
  @j.inject
  TdLibInitializer(this.client);

  final TdClient client;

  Future<void> init() => client.init();
}
