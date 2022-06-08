import 'package:app/src/app/tg_app.dart';
import 'package:app/src/feature/feature_provider.dart';
import 'package:app/src/navigation/chat_router_delegate.dart';
import 'package:app/src/navigation/common_screen_router_impl.dart';
import 'package:app/src/navigation/key_generator.dart';
import 'package:app/src/navigation/navigation_router.dart';
import 'package:core/core.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tg_logger_api/tg_logger_api.dart';

@j.module
abstract class AppNavigationModule {
  @j.provides
  @j.singleton
  static CommonScreenRouterImpl provideCommonScreenRouter(
    FeatureProvider featureProvider,
    ISplitNavigationDelegate navigationDelegate,
    KeyGenerator keyGenerator,
    ChatRouterDelegate chatRouterDelegate,
    ILogger logger,
    MyChatProvider myChatProvider,
  ) =>
      CommonScreenRouterImpl(
        myChatProvider: myChatProvider,
        logger: logger,
        chatRouterDelegate: chatRouterDelegate,
        dialogNavigatorKey: TgApp.navigatorKey,
        featureProvider: featureProvider,
        navigationDelegate: navigationDelegate,
        keyGenerator: keyGenerator,
      );
}
