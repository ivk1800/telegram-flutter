library feature_shared_media;

import 'package:flutter/widgets.dart';

import 'src/shared_content_type.dart';

export 'src/shared_content_type.dart';

abstract class ISharedMediaFeatureApi {
  ISharedMediaScreenFactory get sharedMediaScreenFactory;
}

abstract class ISharedMediaScreenFactory {
  Widget create(BuildContext context, SharedContentType type);
}
