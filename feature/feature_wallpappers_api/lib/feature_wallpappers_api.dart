library feature_wallpappers_api;

import 'package:flutter/widgets.dart';

abstract class IWallpappersFeatureApi {
  IWallpappersWidgetFactory get screenWidgetFactory;
}

abstract class IWallpappersWidgetFactory {
  Widget create();
}
