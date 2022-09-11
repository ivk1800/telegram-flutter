import 'archived_stickers_widget_factory.dart';
import 'masks_widget_factory.dart';
import 'sticker_set_screen_factory.dart';
import 'stickers_widget_factory.dart';
import 'trending_stickers_widget_factory.dart';

abstract class IStickersFeatureApi {
  IStickersWidgetFactory get stickersWidgetFactory;

  ITrendingStickersWidgetFactory get trendingStickersWidgetFactory;

  IArchivedStickersWidgetFactory get archivedStickersWidgetFactory;

  IMasksWidgetFactory get masksWidgetFactory;

  IStickerSetScreenFactory get stickerSetScreenFactory;
}
