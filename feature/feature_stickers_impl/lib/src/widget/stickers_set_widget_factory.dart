import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/stickers_set_page.dart';
import 'package:flutter/widgets.dart';

class StickerSetWidgetFactory implements IStickerSetWidgetFactory {
  StickerSetWidgetFactory({required this.dependencies});

  final IStickersFeatureDependencies dependencies;

  @override
  Widget create(int setId) => const StickerSetPage();
}
