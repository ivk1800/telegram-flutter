library feature_stickers_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/src/widget/stickers_widget_factory.dart';
import 'package:localization_api/localization_api.dart';
import 'src/stickers_feature_router.dart';
import 'src/widget/archived_stickers_widget_factory.dart';
import 'src/widget/masks_widget_factory.dart';
import 'src/widget/stickers_set_widget_factory.dart';
import 'src/widget/trending_stickers_widget_factory.dart';
export 'src/stickers_feature_router.dart';

class StickersFeatureApi implements IStickersFeatureApi {
  StickersFeatureApi({required IStickersFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final IStickersFeatureDependencies _dependencies;

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

abstract class IStickersFeatureDependencies {
  ILocalizationManager get localizationManager;

  IConnectionStateProvider get connectionStateProvider;

  IStickerRepository get stickerRepository;

  IStickersFeatureRouter get stickersFeatureRouter;
}
