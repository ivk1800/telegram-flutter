import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:provider/provider.dart';
import 'package:split_view/split_view.dart';

import 'showcase/showcase_list_page.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({
    Key? key,
  }) : super(key: key);

  @override
  _ShowcasePageState createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  static final GlobalKey<SplitViewState> splitViewNavigatorKey =
      GlobalKey<SplitViewState>();

  late Future<_ShowcaseData> _showcaseDataFuture;

  @override
  void initState() {
    _showcaseDataFuture = Future<_ShowcaseData>(() async {
      final LocalizationManager localizationManager = LocalizationManager();
      await localizationManager.init('en', 'en');

      return _ShowcaseData(
        localizationManager: localizationManager,
      );
    }).then((_ShowcaseData value) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        splitViewNavigatorKey.currentState?.push(
          key: UniqueKey(),
          builder: (_) => const ShowcaseListPage(),
          container: ContainerType.left,
        );
      });
      return value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_ShowcaseData>(
      future: _showcaseDataFuture,
      builder: (_, AsyncSnapshot<_ShowcaseData?> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        return MultiProvider(
          providers: <Provider<dynamic>>[
            Provider<ILocalizationManager>.value(
              value: snapshot.data!.localizationManager,
            ),
          ],
          child: SplitView(
            key: splitViewNavigatorKey,
          ),
        );
      },
    );
  }
}

class _ShowcaseData {
  _ShowcaseData({
    required this.localizationManager,
  });

  final ILocalizationManager localizationManager;
}
