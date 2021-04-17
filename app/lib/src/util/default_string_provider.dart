import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/util/string_provider.dart';

class DefaultStringProvider implements IStringsProvider {
  @j.inject
  DefaultStringProvider();

  @override
  String get devices => 'Devices';

  @override
  String get settings => 'Settings';

  @override
  String get sticker => 'Sticker';
}
