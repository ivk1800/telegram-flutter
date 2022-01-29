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
  });
}
