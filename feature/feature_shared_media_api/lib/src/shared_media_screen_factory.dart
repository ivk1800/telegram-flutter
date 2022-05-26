import 'package:flutter/widgets.dart';

import 'shared_content_type.dart';

abstract class ISharedMediaScreenFactory {
  Widget create(SharedContentType type);
}
