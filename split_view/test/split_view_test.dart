// ignore_for_file: cascade_invocations
import 'package:flutter/widgets.dart';
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
    _defaultCompactLayoutMergeStrategyGroup();
  });

  _removeUntilLSplitModeGroup();

  _willPopSplitModeGroup();
  _willPopCompactGroup();
}

void _willPopCompactGroup() {
  testWidgets('should pop right page by back press', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.right, pageId: 2);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[1, 2],
    );

    await controller.backPress(didPop: true);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[1],
    );
  });

  testWidgets('should pop top page by back press', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[1, 2],
    );

    await controller.backPress(didPop: true);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[1],
    );
  });

  testWidgets('should pop left page by back press', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.left, pageId: 2);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[1, 2],
    );

    await controller.backPress(didPop: true);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[1],
    );
  });
}

void _willPopSplitModeGroup() {
  testWidgets('should pop left page by back press', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.left, pageId: 2);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1, 2],
    );

    await controller.backPress(didPop: true);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1],
    );
  });

  testWidgets('should pop right page by back press', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.right, pageId: 1);
    controller.addPage(container: ContainerType.right, pageId: 2);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1, 2],
    );

    await controller.backPress(didPop: true);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1],
    );
  });

  testWidgets('should pop top page by back press', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1, 2],
    );

    await controller.backPress(didPop: true);

    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1],
    );
  });

  //////////////////////////////////////////////////////////////////////////////

  testWidgets('should not pop by back press if single left page', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1],
    );

    await controller.backPress(didPop: false);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1],
    );
  });

  testWidgets('should not pop by back press if single right page', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.right, pageId: 1);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1],
    );

    await controller.backPress(didPop: false);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1],
    );
  });

  testWidgets('should not pop by back press if single top page', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 1);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1],
    );

    await controller.backPress(didPop: false);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1],
    );
  });

  testWidgets(
      'should not pop by back press if one page in left and right containers', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.right, pageId: 1);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1],
    );
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1],
    );

    await controller.backPress(didPop: false);
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1],
    );
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1],
    );
  });
}

void _removeUntilLSplitModeGroup() {
  testWidgets('should remove until first page from left container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.left, pageId: 2);
    controller.addPage(container: ContainerType.left, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.left,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1],
    );
  });

  testWidgets('should remove all pages from left container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.left, pageId: 2);
    controller.addPage(container: ContainerType.left, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.left,
      (PageNode node) => false,
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });

  testWidgets('should remove all pages if page not found in left container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.left, pageId: 2);
    controller.addPage(container: ContainerType.left, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.left,
      (PageNode node) => node.pageKey == const ValueKey<int>(4),
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });

  testWidgets('should ignore remove until action if single page in container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.left, pageId: 1);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1],
    );

    controller.splitView.removeUntil(
      ContainerType.left,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.left,
      pages: const <int>[1],
    );
  });

  testWidgets('should ignore remove until action if left container is empty', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    await tester.pump();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);

    controller.splitView.removeUntil(
      ContainerType.left,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });

  testWidgets('should remove until first page from right container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.right, pageId: 1);
    controller.addPage(container: ContainerType.right, pageId: 2);
    controller.addPage(container: ContainerType.right, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.right,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1],
    );
  });

  testWidgets('should remove all pages from right container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.right, pageId: 1);
    controller.addPage(container: ContainerType.right, pageId: 2);
    controller.addPage(container: ContainerType.right, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.right,
      (PageNode node) => false,
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });

  testWidgets('should remove all pages if page not found in right container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.right, pageId: 1);
    controller.addPage(container: ContainerType.right, pageId: 2);
    controller.addPage(container: ContainerType.right, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.right,
      (PageNode node) => node.pageKey == const ValueKey<int>(4),
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });

  testWidgets('should ignore remove until action if single page in container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.right, pageId: 1);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1],
    );

    controller.splitView.removeUntil(
      ContainerType.right,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.right,
      pages: const <int>[1],
    );
  });

  testWidgets('should ignore remove until action if right container is empty', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    await tester.pump();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);

    controller.splitView.removeUntil(
      ContainerType.right,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });

  testWidgets('should remove until first page from top container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    controller.addPage(container: ContainerType.top, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.top,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1],
    );
  });

  testWidgets('should remove all pages from top container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    controller.addPage(container: ContainerType.top, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.top,
      (PageNode node) => false,
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });

  testWidgets('should remove all pages if page not found in top container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    controller.addPage(container: ContainerType.top, pageId: 3);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1, 2, 3],
    );

    controller.splitView.removeUntil(
      ContainerType.top,
      (PageNode node) => node.pageKey == const ValueKey<int>(4),
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });

  testWidgets('should ignore remove until action if single page in container', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    controller.addPage(container: ContainerType.top, pageId: 1);
    await tester.pump();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1],
    );

    controller.splitView.removeUntil(
      ContainerType.top,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.top,
      pages: const <int>[1],
    );
  });

  testWidgets('should ignore remove until action if top container is empty', (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.largeScreen();
    await tester.pump();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);

    controller.splitView.removeUntil(
      ContainerType.top,
      (PageNode node) => node.pageKey == const ValueKey<int>(1),
    );
    await tester.pumpAndSettle();

    controller.expectDisplayedNavigators(const <NavigatorLocation>[]);
  });
}

void _defaultCompactLayoutMergeStrategyGroup() {
  testWidgets(
      'should display ordered pages if add to with order left -> right -> top',
      (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.left, pageId: 3);
    controller.addPage(container: ContainerType.right, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    await tester.pump();

    controller.expectCompactNavigator();
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[3, 1, 2],
    );
  });

  testWidgets(
      'should display ordered pages if add to with order left -> top -> right',
      (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.left, pageId: 3);
    controller.addPage(container: ContainerType.top, pageId: 1);
    controller.addPage(container: ContainerType.right, pageId: 2);
    await tester.pump();

    controller.expectCompactNavigator();
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[3, 2, 1],
    );
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
    controller.addPage(container: ContainerType.left, pageId: 3);
    controller.addPage(container: ContainerType.right, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    await tester.pump();

    controller.expectCompactNavigator();
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[3, 1, 2],
    );
  });

  testWidgets(
      'should display ordered pages if add to with order top -> left -> right',
      (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.top, pageId: 3);
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.right, pageId: 2);
    await tester.pump();

    controller.expectCompactNavigator();
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[1, 2, 3],
    );
  });

  testWidgets(
      'should display ordered pages if add to with order top -> right -> left',
      (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.top, pageId: 3);
    controller.addPage(container: ContainerType.right, pageId: 1);
    controller.addPage(container: ContainerType.left, pageId: 2);
    await tester.pump();

    controller.expectCompactNavigator();
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[2, 1, 3],
    );
  });

  testWidgets(
      'should display ordered pages if add to with order right -> top -> left',
      (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.right, pageId: 3);
    controller.addPage(container: ContainerType.top, pageId: 1);
    controller.addPage(container: ContainerType.left, pageId: 2);
    await tester.pump();

    controller.expectCompactNavigator();
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[2, 3, 1],
    );
  });

  testWidgets(
      'should display ordered pages if add to with order right -> left -> top',
      (
    WidgetTester tester,
  ) async {
    final TestSplitViewController controller =
        TestSplitViewController(tester: tester);
    await controller.setup();
    controller.compactScreen();
    controller.addPage(container: ContainerType.right, pageId: 3);
    controller.addPage(container: ContainerType.left, pageId: 1);
    controller.addPage(container: ContainerType.top, pageId: 2);
    await tester.pump();

    controller.expectCompactNavigator();
    controller.expectPagesOrder(
      navigatorLocation: NavigatorLocation.compact,
      pages: const <int>[1, 3, 2],
    );
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
