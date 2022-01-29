// ignore_for_file: cascade_invocations
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:split_view/split_view.dart';

Future<void> _wrapAndPump(WidgetTester tester, Widget widget) async {
  final MaterialApp wrapped = MaterialApp(home: widget);
  await tester.pumpWidget(wrapped);
}

class TestPage extends StatelessWidget {
  const TestPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('page $id'),
    );
  }
}

class TestSplitViewController {
  TestSplitViewController({required this.tester});

  final WidgetTester tester;

  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized()
          as TestWidgetsFlutterBinding;

  final GlobalKey<SplitViewState> splitViewNavigatorKey =
      GlobalKey<SplitViewState>();

  Future<void> setup() async {
    binding.window.devicePixelRatioTestValue = 1.0;
    await _wrapAndPump(tester, SplitView(key: splitViewNavigatorKey));
    expect(find.byType(SplitView), findsOneWidget);
  }

  int addPage({
    required ContainerType container,
    required int pageId,
  }) {
    splitViewNavigatorKey.currentState!.push(
      key: ValueKey<int>(pageId),
      builder: (BuildContext context) {
        return TestPage(
          id: pageId,
        );
      },
      container: container,
    );
    return pageId;
  }

  void compactScreen() {
    binding.window.physicalSizeTestValue = const Size(300, 300);
  }

  void largeScreen() {
    binding.window.physicalSizeTestValue = const Size(1024, 1024);
  }

  void expectCompactNavigator() {
    expectDisplayedNavigators(<NavigatorLocation>[NavigatorLocation.compact]);
  }

  void expectOnlyLeftNavigator() {
    expectDisplayedNavigators(<NavigatorLocation>[NavigatorLocation.left]);
  }

  void expectOnlyRightNavigator() {
    expectDisplayedNavigators(<NavigatorLocation>[NavigatorLocation.right]);
  }

  void expectOnlyTopNavigator() {
    expectDisplayedNavigators(<NavigatorLocation>[NavigatorLocation.top]);
  }

  void expectDisplayedNavigators(List<NavigatorLocation> navigators) {
    final List<NavigatorLocation> existNavigators = <NavigatorLocation>[
      if (_findNavigatorByLocation(NavigatorLocation.left) != null)
        NavigatorLocation.left,
      if (_findNavigatorByLocation(NavigatorLocation.right) != null)
        NavigatorLocation.right,
      if (_findNavigatorByLocation(NavigatorLocation.top) != null)
        NavigatorLocation.top,
      if (_findNavigatorByLocation(NavigatorLocation.compact) != null)
        NavigatorLocation.compact,
    ];

    for (final NavigatorLocation value in navigators) {
      existNavigators.remove(value);
    }
    expect(existNavigators.length, 0);
  }

  void expectTotalNavigatorsCount(int count) {
    expect(
      find.descendant(
          of: find.byType(SplitView), matching: find.byType(Navigator)),
      findsNWidgets(count),
    );
  }

  void expectLeftAndRightNavigator() {
    expect(
      find.descendant(
          of: find.byType(SplitView), matching: find.byType(Navigator)),
      findsNWidgets(2),
    );
  }

  void expectThreeNavigator() {
    expect(
      find.descendant(
          of: find.byType(SplitView), matching: find.byType(Navigator)),
      findsNWidgets(3),
    );
  }

  void expectPagesOrder({
    required NavigatorLocation navigatorLocation,
    required List<int> pages,
  }) {
    expect(
      tester
          .widgetList(_pagesFinder(navigatorLocation: navigatorLocation))
          .toList()
          .cast<TestPage>()
          .map((TestPage e) => e.id),
      pages,
    );
  }

  void expectPagesCount({
    required NavigatorLocation navigatorLocation,
    required int count,
  }) {
    expect(
      tester
          .widgetList(_pagesFinder(navigatorLocation: navigatorLocation))
          .toList()
          .length,
      count,
    );
  }

  void expectBackButtonDisplayedAtTopPage({
    required bool displayed,
    required NavigatorLocation navigatorLocation,
  }) {
    final List<Widget> pages = tester
        .widgetList(_pagesFinder(navigatorLocation: navigatorLocation))
        .toList();
    expect(pages.length, greaterThanOrEqualTo(1));

    final Finder iconButtonFinder = find.descendant(
        of: find.byWidget(pages.last), matching: find.byType(IconButton));
    expect(
      iconButtonFinder,
      displayed ? findsOneWidget : findsNothing,
    );
  }

  Future<void> tapBackButtonAtTopPage({
    required NavigatorLocation navigatorLocation,
  }) async {
    final List<Widget> pages = tester
        .widgetList(_pagesFinder(navigatorLocation: navigatorLocation))
        .toList();
    expect(pages.length, greaterThanOrEqualTo(1));

    final Finder iconButtonFinder = find.descendant(
        of: find.byWidget(pages.last), matching: find.byType(IconButton));
    expect(
      iconButtonFinder,
      findsOneWidget,
    );
    await tester.tap(iconButtonFinder);
  }

  Element? _findNavigatorByLocation(NavigatorLocation location) {
    // todo: magic numbers
    final List<Element> navigators = _findNavigators();
    expect(navigators.length, greaterThanOrEqualTo(1));
    switch (location) {
      case NavigatorLocation.left:
        return navigators
            .firstWhereOrNull((Element element) => element.size!.width == 350);
      case NavigatorLocation.right:
        return navigators.firstWhereOrNull((Element element) =>
            element.size!.width != 350 &&
            element.size!.width != binding.window.physicalSize.width &&
            element.size!.height == binding.window.physicalSize.height);
      case NavigatorLocation.top:
        return navigators.firstWhereOrNull((Element element) =>
            element.size!.height == 600 && element.size!.width == 500);
      case NavigatorLocation.compact:
        return navigators.firstWhereOrNull(
            (Element element) => element.size! == binding.window.physicalSize);
    }
  }

  Finder _pagesFinder({
    required NavigatorLocation navigatorLocation,
  }) {
    final Element? navigator = _findNavigatorByLocation(navigatorLocation);
    expect(navigator, isNotNull);

    return find.descendant(
      of: find.byWidget(navigator!.widget),
      matching: find.byType(
        TestPage,
        skipOffstage: false,
      ),
      skipOffstage: false,
    );
  }

  List<Element> _findNavigators() {
    return find
        .descendant(
            of: find.byType(SplitView), matching: find.byType(Navigator))
        .evaluate()
        .toList();
  }
}

enum NavigatorLocation {
  left,
  right,
  top,
  compact,
}
