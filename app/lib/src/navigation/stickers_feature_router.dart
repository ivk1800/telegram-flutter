import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:app/src/feature/feature.dart';
import 'package:split_view/split_view.dart';
import 'package:jugger/jugger.dart' as j;
import 'navigation.dart';

class StickersFeatureRouterImpl implements IStickersFeatureRouter {
  @j.inject
  StickersFeatureRouterImpl(
    FeatureFactory featureFactory,
    SplitNavigationRouter navigationRouter,
  )   : _navigationRouter = navigationRouter,
        _featureFactory = featureFactory;

  final SplitNavigationRouter _navigationRouter;
  final FeatureFactory _featureFactory;

  @override
  void toArchivedStickers() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createStickersFeatureApi()
          .archivedStickersWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toMasks() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createStickersFeatureApi()
          .masksWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }

  @override
  void toStickerSet(int setId) {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createStickersFeatureApi()
          .stickerSetWidgetFactory
          .create(setId),
      container: ContainerType.top,
    );
  }

  @override
  void toTrendingStickers() {
    _navigationRouter.push(
      key: UniqueKey(),
      builder: (BuildContext context) => _featureFactory
          .createStickersFeatureApi()
          .trendingStickersWidgetFactory
          .create(),
      container: ContainerType.top,
    );
  }
}
