import 'package:flutter/material.dart';
import 'package:presentation/src/app/app_delegate.dart';
import 'package:presentation/src/widget/widget.dart';
import 'package:td_client/td_client.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/di/component/app_delegate_component.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.client}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  final TdClient client;

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
        navigatorKey: MyApp.navigatorKey,
        theme: ThemeData(
          platform: TargetPlatform.iOS,
          primaryColor: const Color(0xff5682a3),
          accentColor: const Color(0xff598fba),
        ),
        home: Container(),
      ),
    );
  }
}
