library feature_stickers_api;

import 'package:flutter/widgets.dart';

abstract class IStickersFeatureApi {
  IStickersWidgetFactory get stickersWidgetFactory;

  ITrendingStickersWidgetFactory get trendingStickersWidgetFactory;

  IArchivedStickersWidgetFactory get archivedStickersWidgetFactory;

  IMasksWidgetFactory get masksWidgetFactory;

  IStickerSetWidgetFactory get stickerSetWidgetFactory;
}

abstract class IStickersWidgetFactory {
  Widget create();
}

abstract class ITrendingStickersWidgetFactory {
  Widget create();
}

abstract class IArchivedStickersWidgetFactory {
  Widget create();
}

abstract class IMasksWidgetFactory {
  Widget create();
}

abstract class IStickerSetWidgetFactory {
  Widget create(int setId);
}
