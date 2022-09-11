library feature_stickers_impl;

import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/src/di/stickers_component.dart';
import 'package:feature_stickers_impl/src/di/stickers_component.jugger.dart';
import 'package:feature_stickers_impl/src/widget/stickers_widget_factory.dart';

import 'screen/stickers_set/stickers_set_screen_factory.dart';
import 'stickers_feature_dependencies.dart';
import 'widget/archived_stickers_widget_factory.dart';
import 'widget/masks_widget_factory.dart';
import 'widget/trending_stickers_widget_factory.dart';

class StickersFeature implements IStickersFeatureApi {
  StickersFeature({required StickersFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final StickersFeatureDependencies _dependencies;

  late final IStickersComponent _component =
      JuggerStickersComponentBuilder().dependencies(_dependencies).build();

  @override
  late final IStickersWidgetFactory stickersWidgetFactory =
      StickersWidgetFactory(dependencies: _dependencies);

  @override
  late final IArchivedStickersWidgetFactory archivedStickersWidgetFactory =
      ArchivedStickersWidgetFactory(dependencies: _dependencies);

  @override
  late final IMasksWidgetFactory masksWidgetFactory =
      MasksWidgetFactory(dependencies: _dependencies);

  @override
  late final ITrendingStickersWidgetFactory trendingStickersWidgetFactory =
      TrendingStickersWidgetFactory(dependencies: _dependencies);

  @override
  late final IStickerSetScreenFactory stickerSetScreenFactory =
      StickerSetWidgetFactory(parentComponent: _component);
}
