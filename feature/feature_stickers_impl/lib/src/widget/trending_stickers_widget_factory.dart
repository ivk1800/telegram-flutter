import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/screen/trending_stickers/trending_stickers_page.dart';
import 'package:flutter/widgets.dart';

class TrendingStickersWidgetFactory implements ITrendingStickersWidgetFactory {
  TrendingStickersWidgetFactory({required this.dependencies});

  final IStickersFeatureDependencies dependencies;

  @override
  Widget create() => const TrendingStickersPage();
}
