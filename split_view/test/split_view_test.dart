// ignore_for_file: cascade_invocations
import 'package:flutter_test/flutter_test.dart';
import 'package:split_view/split_view.dart';

import 'test_split_view_controller.dart';

void main() {
  group('compact mode', () {
    testWidgets('should not display empty navigator in compact mode', (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.compactScreen();

      controller.expectTotalNavigatorsCount(0);
    });

    testWidgets('should display page if add to left container', (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.compactScreen();
      controller.addPage(container: ContainerType.left, pageId: 1);
      await tester.pump();

      controller.expectCompactNavigator();
      controller.expectPagesOrder(
        navigatorLocation: NavigatorLocation.compact,
        pages: const <int>[1],
      );
    });

    testWidgets('should display page if add to right container', (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.compactScreen();
      controller.addPage(container: ContainerType.right, pageId: 1);
      await tester.pump();

      controller.expectCompactNavigator();
      controller.expectPagesOrder(
          navigatorLocation: NavigatorLocation.compact, pages: const <int>[1]);
    });

    testWidgets('should display page if add to top container', (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.compactScreen();
      controller.addPage(container: ContainerType.top, pageId: 1);
      await tester.pump();

      controller.expectCompactNavigator();
      controller.expectPagesOrder(
          navigatorLocation: NavigatorLocation.compact, pages: const <int>[1]);
    });

    testWidgets(
        'should display ordered pages if add to with order left -> right -> top',
        (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.compactScreen();
      controller.addPage(
        container: ContainerType.left,
        pageId: 3,
      );
      controller.addPage(container: ContainerType.right, pageId: 1);
      controller.addPage(container: ContainerType.top, pageId: 2);
      await tester.pump();

      controller.expectCompactNavigator();
      controller.expectPagesOrder(
        navigatorLocation: NavigatorLocation.compact,
        pages: const <int>[3, 1, 2],
      );
    });

    // todo add more combinations
  });
  group('split mode', () {
    testWidgets('should not display empty navigator in split mode', (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.largeScreen();

      controller.expectTotalNavigatorsCount(0);
    });

    testWidgets('should display page if add to left container', (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.largeScreen();
      controller.addPage(container: ContainerType.left, pageId: 1);
      await tester.pump();

      controller.expectOnlyLeftNavigator();
      controller.expectPagesOrder(
        navigatorLocation: NavigatorLocation.left,
        pages: const <int>[1],
      );
    });

    testWidgets('should display page if add to right container', (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.largeScreen();
      controller.addPage(container: ContainerType.right, pageId: 1);
      await tester.pump();

      controller.expectOnlyRightNavigator();
      controller.expectPagesOrder(
        navigatorLocation: NavigatorLocation.right,
        pages: const <int>[1],
      );
    });

    testWidgets('should display page if add to top container', (
      WidgetTester tester,
    ) async {
      final TestSplitViewController controller =
          TestSplitViewController(tester: tester);
      await controller.setup();
      controller.largeScreen();
      controller.addPage(container: ContainerType.top, pageId: 1);
      await tester.pump();

      controller.expectOnlyTopNavigator();
      controller.expectPagesOrder(
        navigatorLocation: NavigatorLocation.top,
        pages: const <int>[1],
      );
    });

    _topPagesGroup();
  });
}

void _topPagesGroup() {
  testWidgets(
      'should remove pages from top if barrier tapped and if added left page', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    await tester.pump();

    controller.expectDisplayedNavigators(
      <NavigatorLocation>[
        NavigatorLocation.left,
        NavigatorLocation.top,
      ],
    );

    await tester.tapAt(const Offset(10, 10));
    await tester.pump();

    controller.expectDisplayedNavigators(
      <NavigatorLocation>[NavigatorLocation.left],
    );
  });

  testWidgets(
      'should remove pages from top if barrier tapped and if added right page',
      (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.right, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    await tester.pump();

    controller.expectDisplayedNavigators(
      <NavigatorLocation>[
        NavigatorLocation.right,
        NavigatorLocation.top,
      ],
    );

    await tester.tapAt(const Offset(10, 10));
    await tester.pump();

    controller.expectDisplayedNavigators(
      <NavigatorLocation>[NavigatorLocation.right],
    );
  });

  testWidgets(
      'should not remove pages from top if barrier tapped and if displayed only top page',
      (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 2);
    await tester.pump();

    controller.expectDisplayedNavigators(
      <NavigatorLocation>[NavigatorLocation.top],
    );

    await tester.tapAt(const Offset(10, 10));
    await tester.pump();

    controller.expectDisplayedNavigators(
      <NavigatorLocation>[NavigatorLocation.top],
    );
  });

  testWidgets('should display back button on second top page', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 2);
    controller.addPage(container: ContainerType.top, pageId: 1);
    await tester.pump();

    controller.expectPagesCount(
      navigatorLocation: NavigatorLocation.top,
      count: 2,
    );

    controller.expectBackButtonDisplayedAtTopPage(
      displayed: true,
      navigatorLocation: NavigatorLocation.top,
    );
  });

  testWidgets('should not display back button on only single top page', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 1);
    await tester.pump();

    controller.expectPagesCount(
      navigatorLocation: NavigatorLocation.top,
      count: 1,
    );

    controller.expectBackButtonDisplayedAtTopPage(
      displayed: false,
      navigatorLocation: NavigatorLocation.top,
    );
  });

  testWidgets('should display back button on single top page', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 1);
    await tester.pump();

    controller.expectPagesCount(
      navigatorLocation: NavigatorLocation.top,
      count: 1,
    );

    controller.expectBackButtonDisplayedAtTopPage(
      displayed: true,
      navigatorLocation: NavigatorLocation.top,
    );
  });

  testWidgets('should remove from top if back button tapped', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 2);
    controller.addPage(container: ContainerType.top, pageId: 1);
    await tester.pump();

    controller.expectPagesCount(
      navigatorLocation: NavigatorLocation.top,
      count: 2,
    );

    await controller.tapBackButtonAtTopPage(
        navigatorLocation: NavigatorLocation.top);
    await tester.pumpAndSettle();

    controller.expectPagesCount(
      navigatorLocation: NavigatorLocation.top,
      count: 1,
    );
  });
}
