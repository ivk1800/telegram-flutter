import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/screen/masks/masks_page.dart';
import 'package:flutter/widgets.dart';

class MasksWidgetFactory implements IMasksWidgetFactory {
  MasksWidgetFactory({required this.dependencies});

  final StickersFeatureDependencies dependencies;

  @override
  Widget create() => const MasksPage();
}
