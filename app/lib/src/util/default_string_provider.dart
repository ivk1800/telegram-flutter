import 'package:jugger/jugger.dart' as j;
import 'package:app/src/util/string_provider.dart';

class DefaultStringProvider implements IStringsProvider {
  @j.inject
  DefaultStringProvider();

  @override
  String get devices => 'Devices';

  @override
  String get settings => 'Settings';

  @override
  String get sticker => 'Sticker';

  @override
  String get connectionStateConnecting => 'Connecting...';

  @override
  String get connectionStateConnectingToProxy => 'Connecting to proxy';

  @override
  String get connectionStateUpdating => 'Updating';

  @override
  String get connectionStateWaitingForNetwork => 'Waiting for network...';

  @override
  String get folders => 'Folders';
}
