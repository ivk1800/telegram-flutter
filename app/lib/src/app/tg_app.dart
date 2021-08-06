import 'package:flutter/material.dart';
import 'package:app/src/app/app_delegate.dart';
import 'package:app/src/widget/widget.dart';
import 'package:split_view/split_view.dart';
import 'package:td_client/td_client.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:app/src/di/component/app_delegate_component.dart';

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

class TgAppState extends State<TgApp> with WidgetsBindingObserver {
  @j.inject
  late AppDelegate appDelegate;

  @override
  void initState() {
    inject();
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      appDelegate.onPause();
    } else if (state == AppLifecycleState.resumed) {
      appDelegate.onResume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TdImageLoader(
      client: widget.client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: TgApp.navigatorKey,
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          primaryColor: const Color(0xff5682a3),
          accentColor: const Color(0xff598fba),
        ),
        home: Container(
          // TODO maybe add color property to SplitView?
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SplitView(
            key: TgApp.splitViewNavigatorKey,
          ),
        ),
      ),
    );
  }
}
