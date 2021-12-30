import 'package:app/src/app/app_delegate.dart';
import 'package:app/src/di/component/app_delegate_component.dart';
import 'package:flutter/material.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:split_view/split_view.dart';
import 'package:td_client/td_client.dart';

import 'tg_theme.dart';

class TgApp extends StatefulWidget {
  const TgApp({Key? key, required this.client}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<SplitViewState> splitViewNavigatorKey =
      GlobalKey<SplitViewState>();

  final TdClient client;

  @override
  TgAppState createState() => TgAppState();
}

class TgAppState extends State<TgApp> {
  @j.inject
  late AppDelegate appDelegate;

  @override
  void initState() {
    inject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return TgAppTheme(child: child!);
      },
      debugShowCheckedModeBanner: false,
      navigatorKey: TgApp.navigatorKey,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
        platform: TargetPlatform.android,
        primaryColor: const Color(0xff5682a3),
        colorScheme: ThemeData.light().colorScheme.copyWith(
              secondary: const Color(0xff598fba),
            ),
        appBarTheme: const AppBarTheme(
          color: Color(0xff5682a3),
        ),
      ),
      home: Container(
        // TODO maybe add color property to SplitView?
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SplitView(
          key: TgApp.splitViewNavigatorKey,
        ),
      ),
    );
  }
}
