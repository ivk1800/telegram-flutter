import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:jugger/jugger.dart' as j;

@j.module
abstract class TgAppBarModule {
  @j.provides
  static tg.ConnectionStateWidgetFactory provideConnectionStateWidgetFactory(
    IConnectionStateProvider connectionStateProvider,
  ) =>
      tg.ConnectionStateWidgetFactory(
        connectionStateProvider: connectionStateProvider,
      );

  @j.provides
  static tg.TgAppBarFactory provideTgAppBarFactory(
    tg.ConnectionStateWidgetFactory connectionStateWidgetFactory,
  ) =>
      tg.TgAppBarFactory(
        connectionStateWidgetFactory: connectionStateWidgetFactory,
      );
}
