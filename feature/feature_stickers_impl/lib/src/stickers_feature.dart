library feature_stickers_impl;

import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/src/widget/stickers_widget_factory.dart';

import 'stickers_feature_dependencies.dart';
import 'widget/archived_stickers_widget_factory.dart';
import 'widget/masks_widget_factory.dart';
import 'widget/stickers_set_widget_factory.dart';
import 'widget/trending_stickers_widget_factory.dart';

class StickersFeature implements IStickersFeatureApi {
  StickersFeature({required StickersFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final StickersFeatureDependencies _dependencies;

  StickersWidgetFactory? _stickersWidgetFactory;

  @override
  IStickersWidgetFactory get stickersWidgetFactory =>
      _stickersWidgetFactory ??
      (_stickersWidgetFactory =
          StickersWidgetFactory(dependencies: _dependencies));

  ArchivedStickersWidgetFactory? _archivedStickersWidgetFactory;

  @override
  IArchivedStickersWidgetFactory get archivedStickersWidgetFactory =>
      _archivedStickersWidgetFactory ??
      (_archivedStickersWidgetFactory =
          ArchivedStickersWidgetFactory(dependencies: _dependencies));

  MasksWidgetFactory? _masksWidgetFactory;

  @override
  IMasksWidgetFactory get masksWidgetFactory =>
      _masksWidgetFactory ??
      (_masksWidgetFactory = MasksWidgetFactory(dependencies: _dependencies));

  TrendingStickersWidgetFactory? _trendingStickersWidgetFactory;

  @override
  ITrendingStickersWidgetFactory get trendingStickersWidgetFactory =>
      _trendingStickersWidgetFactory ??
      (_trendingStickersWidgetFactory =
          TrendingStickersWidgetFactory(dependencies: _dependencies));

  StickerSetWidgetFactory? _stickerSetWidgetFactory;

  @override
  IStickerSetWidgetFactory get stickerSetWidgetFactory =>
      _stickerSetWidgetFactory ??
      (_stickerSetWidgetFactory =
          StickerSetWidgetFactory(dependencies: _dependencies));
}
