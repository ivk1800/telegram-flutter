import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:split_view/src/page_animation_strategy.dart';
import 'package:split_view/src/page_route_configurator.dart';
import 'package:split_view/src/split_view_scope.dart';

import 'page_animation_strategy.dart';
import 'page_pop_strategy.dart';
import 'split_layout_delegate.dart';
import 'split_view_delegate.dart';

class Config {
  const Config({
    required this.leftContainerWidth,
    required this.minLeftContainerWidth,
    required this.maxLeftContainerWidth,
    required this.maxCompactWidth,
    required this.isDraggableDivider,
    required this.draggableDividerWidth,
    required this.draggableDividerColor,
    required this.topContainerConfig,
  });

  final double leftContainerWidth;
  final double minLeftContainerWidth;
  final double maxLeftContainerWidth;
  final double maxCompactWidth;
  final double draggableDividerWidth;

  final bool isDraggableDivider;
  final Color draggableDividerColor;
  final TopContainerConfig topContainerConfig;
}

class TopContainerConfig {
  const TopContainerConfig({
    required this.size,
    required this.borderRadius,
    required this.elevation,
  });

  final Size size;
  final double borderRadius;
  final double elevation;
}

class SplitView extends StatefulWidget {
  const SplitView({
    required this.delegate,
    this.observer,
    this.config = const Config(
      minLeftContainerWidth: 290,
      leftContainerWidth: 350,
      maxLeftContainerWidth: 400,
      isDraggableDivider: true,
      draggableDividerWidth: 6,
      topContainerConfig: TopContainerConfig(
        size: Size(530, 528),
        borderRadius: 0,
        elevation: 40,
      ),
      draggableDividerColor: Colors.grey,
      maxCompactWidth: 699,
    ),
    Key? key,
  }) : super(key: key);

  final Config config;
  final SplitViewDelegate delegate;
  final SplitViewNavigatorObserver? observer;

  @override
  SplitViewState createState() => SplitViewState();

  static SplitViewState of(BuildContext context) {
    SplitViewState? navigator;
    if (context is StatefulElement && context.state is NavigatorState) {
      navigator = context.state as SplitViewState;
    }
    navigator = navigator ?? context.findAncestorStateOfType<SplitViewState>();
    return navigator!;
  }
}

abstract class SplitViewNavigatorObserver {
  const SplitViewNavigatorObserver();

  void didRemove(LocalKey key, ContainerType container);

  void didAdd(LocalKey key, ContainerType container);
}

enum ContainerType { left, right, top }

class _PageNode implements PageInfo {
  _PageNode({
    required ContainerType container,
    required Page<dynamic> page,
    int? order,
  })  : _page = page,
        _container = container,
        _order = order ?? DateTime.now().millisecondsSinceEpoch;

  final ContainerType _container;
  final int _order;
  final Page<dynamic> _page;

  @override
  LocalKey get pageKey {
    assert(_page.key != null);
    return _page.key!;
  }

  @override
  ContainerType get container => _container;

  @override
  int get order => _order;
}

abstract class PageInfo {
  ContainerType get container;

  int get order;

  LocalKey get pageKey;
}

class _InternalState implements SplitLayoutConfig {
  _InternalState(this.config) : _leftContainerWidth = config.leftContainerWidth;

  final Config config;

  List<_PageNode> leftPages = <_PageNode>[];
  List<_PageNode> rightPages = <_PageNode>[];
  List<_PageNode> topPages = <_PageNode>[];

  Widget rightContainerPlaceholder = const SizedBox.shrink();

  late List<_PageNode> compactPages = const <_PageNode>[];
  bool isCompact = false;

  double _leftContainerWidth = 0;

  double get leftContainerWidth => _leftContainerWidth;

  @override
  // ignore: avoid_setters_without_getters
  set leftContainerWidth(double value) {
    _leftContainerWidth = value;
  }

  @override
  double get maxLeftContainerWidth => config.maxLeftContainerWidth;

  @override
  double get minLeftContainerWidth => config.minLeftContainerWidth;

  int version = 0;
}

class SplitViewState extends State<SplitView> {
  late final _InternalState _internalState = _InternalState(widget.config);

  List<_PageNode> get _leftPages => _internalState.leftPages;

  List<_PageNode> get _rightPages => _internalState.rightPages;

  List<_PageNode> get _topPages => _internalState.topPages;

  late final _PagesContainer _leftPagesContainer = _PagesContainer(
    countFunc: () => _leftPages.length,
    tryPopTopFunc: () async {
      assert(_leftPages.isNotEmpty);
      return !(await _leftNavigatorKey.currentState!.maybePop());
    },
  );

  late final _PagesContainer _rightPagesContainer = _PagesContainer(
    countFunc: () => _rightPages.length,
    tryPopTopFunc: () async {
      assert(_rightPages.isNotEmpty);
      return !(await _rightNavigatorKey.currentState!.maybePop());
    },
  );

  late final _PagesContainer _topPagesContainer = _PagesContainer(
    countFunc: () => _topPages.length,
    tryPopTopFunc: () async {
      assert(_topPages.isNotEmpty);
      return !(await _topNavigatorKey.currentState!.maybePop());
    },
  );

  final GlobalKey<NavigatorState> _compactNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _topNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _leftNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _rightNavigatorKey =
      GlobalKey<NavigatorState>();

  // region public api

  void add({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  }) {
    _add(
      _SimplePage(
        key: key,
        animateRouterProvider: () => _shouldAnimate(key, container),
        builder: builder,
        container: container,
      ),
      container,
    );
  }

  void setRightContainerPlaceholder(Widget widget) {
    _internalState.rightContainerPlaceholder = widget;
    _incrementStateVersion(notify: true);
  }

  void removeUntil(
      ContainerType container, bool Function(_PageNode node) test) {
    void _removeUntil(List<_PageNode> pages) {
      _PageNode? candidate = pages.lastOrNull;
      while (candidate != null) {
        if (test.call(candidate)) {
          return;
        }
        final _PageNode last = pages.removeLast();
        widget.observer?.didRemove(last.pageKey, container);
        candidate = pages.lastOrNull;
      }
    }

    switch (container) {
      case ContainerType.left:
        _removeUntil(_leftPages);
        break;
      case ContainerType.right:
        _removeUntil(_rightPages);
        break;
      case ContainerType.top:
        _removeUntil(_topPages);
        break;
    }
    _refreshCompactPages(notify: true);
  }

  void removeByKey(LocalKey key) {
    void remove(List<_PageNode> pages) {
      final _PageNode page =
          pages.firstWhere((_PageNode page) => page.pageKey == key);
      pages.remove(page);
      _refreshCompactPages(notify: true);
    }

    if (hasKey(key, ContainerType.top)) {
      remove(_topPages);
      widget.observer?.didRemove(key, ContainerType.top);
    } else if (hasKey(key, ContainerType.right)) {
      remove(_rightPages);
      widget.observer?.didRemove(key, ContainerType.right);
    } else if (hasKey(key, ContainerType.left)) {
      remove(_leftPages);
      widget.observer?.didRemove(key, ContainerType.left);
    }
  }

  bool hasKey(LocalKey key, ContainerType container) {
    switch (container) {
      case ContainerType.left:
        return _leftPages.hasKey(key);
      case ContainerType.right:
        return _rightPages.hasKey(key);
      case ContainerType.top:
        return _topPages.hasKey(key);
    }
  }

  // endregion public api

  void _incrementStateVersion({bool notify = false}) {
    void fn() {
      _internalState.version += 1;
    }

    if (notify) {
      setState(fn);
    } else {
      fn.call();
    }
  }

  void _add(_SimplePage page, ContainerType containerType) {
    assert(page.key != null);
    assert(!_leftPages.any((_PageNode element) => element.pageKey == page.key));
    assert(
        !_rightPages.any((_PageNode element) => element.pageKey == page.key));
    assert(!_topPages.any((_PageNode element) => element.pageKey == page.key));
    switch (containerType) {
      case ContainerType.left:
        _leftPages.add(_PageNode(container: containerType, page: page));
        break;
      case ContainerType.right:
        _rightPages.add(_PageNode(container: containerType, page: page));
        break;
      case ContainerType.top:
        _topPages.add(_PageNode(container: containerType, page: page));
        break;
    }
    _refreshCompactPages(notify: true);
    widget.observer?.didAdd(page.key!, containerType);
  }

  void _onSizeChanged(BoxConstraints constraints) {
    if (widget.delegate.compactLayoutStrategy.process(constraints)) {
      if (!_internalState.isCompact) {
        _internalState.isCompact = true;
        _refreshCompactPages();
      }
    } else {
      if (_internalState.isCompact) {
        _internalState.isCompact = false;
        _refreshCompactPages();
      }
    }
  }

  void _refreshCompactPages({bool notify = false}) {
    if (_internalState.isCompact) {
      final List<PageInfo> newPages = widget.delegate.compactLayoutMergeStrategy
          .process(_leftPages, _rightPages, _topPages);

      assert(() {
        for (final PageInfo element in newPages) {
          assert(element is _PageNode);
        }
        return true;
      }());

      _internalState.compactPages = newPages
          // todo clarify contact, must return same pages
          .cast();
      _incrementStateVersion(notify: notify);
    } else {
      _internalState.compactPages = const <_PageNode>[];
      _incrementStateVersion(notify: notify);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplitViewScope(
      state: this,
      version: _internalState.version,
      child: WillPopScope(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            _onSizeChanged(constraints);
            if (_internalState.isCompact) {
              return const _CompactLayout();
            } else {
              return const _SplitLayout();
            }
          },
        ),
        onWillPop: _onWillPop,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_internalState.isCompact) {
      return !(await _compactNavigatorKey.currentState!.maybePop());
    }

    return widget.delegate.pagePopStrategy.onWillPop(
      _leftPagesContainer,
      _rightPagesContainer,
      _topPagesContainer,
    );
  }

  bool _shouldAnimate(LocalKey key, ContainerType container) {
    final PageAnimationStrategy pageAnimationStrategy =
        widget.delegate.pageAnimationStrategy;

    if (_internalState.isCompact) {
      return pageAnimationStrategy.shouldAnimateCompact(
        _internalState.compactPages,
        key,
        container,
      );
    }
    switch (container) {
      case ContainerType.left:
        return pageAnimationStrategy.shouldAnimateLeft(
          _leftPages,
          key,
          container,
        );
      case ContainerType.right:
        return pageAnimationStrategy.shouldAnimateRight(
          _rightPages,
          key,
          container,
        );
      case ContainerType.top:
        return pageAnimationStrategy.shouldAnimateCompact(
          _topPages,
          key,
          container,
        );
    }
  }

  bool _onPopPage(Route<dynamic> route, Object? result) {
    if (!route.didPop(result)) {
      return false;
    }
    if (route.settings is _SimplePage) {
      final _SimplePage page = route.settings as _SimplePage;
      _removeTopFromContainer(page.container);
      _refreshCompactPages(notify: true);
    }

    return true;
  }

  void _removeTopFromContainer(ContainerType container) {
    _PageNode? removed;
    switch (container) {
      case ContainerType.left:
        final _PageNode last = _leftPages.lastWhere(
          (_PageNode element) => element.container == ContainerType.left,
        );
        if (_leftPages.remove(last)) {
          removed = last;
        }
        break;
      case ContainerType.right:
        final _PageNode last = _rightPages.lastWhere(
          (_PageNode element) => element.container == ContainerType.right,
        );
        if (_rightPages.remove(last)) {
          removed = last;
        }
        break;
      case ContainerType.top:
        final _PageNode last = _topPages.lastWhere(
          (_PageNode element) => element.container == ContainerType.top,
        );
        if (_topPages.remove(last)) {
          removed = last;
        }
        break;
    }
    if (removed != null) {
      widget.observer?.didRemove(removed.pageKey, container);
    }
  }

  List<_PageNode> _getPagesOf(ContainerType container) {
    if (_internalState.isCompact) {
      return _internalState.compactPages;
    }

    switch (container) {
      case ContainerType.left:
        return _leftPages;
      case ContainerType.right:
        return _rightPages;
      case ContainerType.top:
        return _topPages;
    }
  }
}

class _SimplePage extends Page<dynamic> {
  _SimplePage({
    required this.builder,
    required this.animateRouterProvider,
    required this.container,
    required LocalKey key,
  })  : _key = GlobalKey(),
        super(key: key);

  final ContainerType container;
  final WidgetBuilder builder;
  final GlobalKey<dynamic> _key;
  final bool Function() animateRouterProvider;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    final SplitViewState splitViewState = SplitViewScope.of(context);
    final PageRouteConfigurator configurator =
        splitViewState.widget.delegate.pageRouteConfigurator;

    return _DefaultRoute<dynamic>(
      settings: this,
      isWillHandlePopInternally: () {
        return !splitViewState._internalState.isCompact
            ? configurator.isWillHandlePopInternally(
                pages: splitViewState._getPagesOf(container),
                key: key!,
                container: container,
              )
            : null;
      },
      isFullscreenDialog: () {
        return !splitViewState._internalState.isCompact
            ? configurator.isFullscreenDialog(
                pages: splitViewState._getPagesOf(container),
                key: key!,
                container: container,
              )
            : null;
      },
      routerDurationProvider: () {
        if (!animateRouterProvider()) {
          return Duration.zero;
        }
        return null;
      },
      builder: (BuildContext context) {
        return KeyedSubtree(key: _key, child: builder.call(context));
      },
    );
  }
}

class _DefaultRoute<T> extends MaterialPageRoute<T> {
  _DefaultRoute({
    required RouteSettings? settings,
    required WidgetBuilder builder,
    required this.isFullscreenDialog,
    required this.isWillHandlePopInternally,
    required this.routerDurationProvider,
  }) : super(builder: builder, settings: settings);

  final Duration? Function() routerDurationProvider;
  final bool? Function() isWillHandlePopInternally;
  final bool? Function() isFullscreenDialog;

  @override
  Duration get transitionDuration {
    return routerDurationProvider() ?? super.transitionDuration;
  }

  @override
  Duration get reverseTransitionDuration {
    return routerDurationProvider() ?? super.reverseTransitionDuration;
  }

  @override
  bool get willHandlePopInternally {
    return isWillHandlePopInternally.call() ?? super.willHandlePopInternally;
  }

  @override
  bool get fullscreenDialog =>
      isFullscreenDialog.call() ?? super.fullscreenDialog;
}

extension _Extensions on List<_PageNode> {
  bool hasKey(LocalKey key) =>
      any((_PageNode element) => element._page.key == key);
}

class _NavigatorContainer extends StatelessWidget {
  const _NavigatorContainer({
    Key? key,
    this.navigatorKey,
    required this.pages,
    required this.onPopPage,
  }) : super(key: key);

  final List<Page<dynamic>> pages;
  final PopPageCallback onPopPage;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return const SizedBox();
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: onPopPage,
    );
  }
}

class _RightNavigatorContainer extends StatelessWidget {
  const _RightNavigatorContainer({
    Key? key,
    required this.pages,
    required this.onPopPage,
    required this.placeholder,
  }) : super(key: key);

  //.map((__PageNode e) => e.page).toList()
  final List<Page<dynamic>> pages;
  final PopPageCallback onPopPage;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return Expanded(child: placeholder);
    }
    final SplitViewState splitViewState = SplitViewScope.of(context);
    return Expanded(
      child: ClipRect(
        child: _NavigatorContainer(
          navigatorKey: splitViewState._rightNavigatorKey,
          onPopPage: onPopPage,
          pages: pages,
        ),
      ),
    );
  }
}

class _TopNavigationContainer extends StatelessWidget {
  const _TopNavigationContainer({
    Key? key,
    required this.isNotSinglePage,
    required this.onPopPage,
    required this.pages,
    required this.onBarrierTap,
  }) : super(key: key);

  final bool isNotSinglePage;
  final PopPageCallback onPopPage;
  final List<Page<dynamic>> pages;
  final GestureTapCallback onBarrierTap;

  @override
  Widget build(BuildContext context) {
    final SplitViewState splitViewState = SplitViewScope.of(context);
    final TopContainerConfig topContainerConfig =
        splitViewState._internalState.config.topContainerConfig;
    return Align(
      key: key,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (isNotSinglePage) {
                onBarrierTap.call();
              }
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Align(
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  topContainerConfig.borderRadius,
                ),
              ),
              elevation: topContainerConfig.elevation,
              child: ClipRect(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: topContainerConfig.size.width,
                    maxHeight: topContainerConfig.size.height,
                  ),
                  child: _NavigatorContainer(
                    navigatorKey: splitViewState._topNavigatorKey,
                    onPopPage: onPopPage,
                    pages: <Page<dynamic>>[
                      // add stub page for trigger navigation button
                      if (isNotSinglePage)
                        _SimplePage(
                          key: UniqueKey(),
                          animateRouterProvider: () => false,
                          builder: (_) => const SizedBox.shrink(),
                          container: ContainerType.top,
                        ),
                      ...pages,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedTopNavigationContainer extends StatelessWidget {
  const _AnimatedTopNavigationContainer({
    Key? key,
    required this.isNotSinglePage,
    required this.onPopPage,
    required this.pages,
    required this.onBarrierTap,
  }) : super(key: key);

  final bool isNotSinglePage;
  final PopPageCallback onPopPage;
  final List<Page<dynamic>> pages;
  final GestureTapCallback onBarrierTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: pages.isEmpty
          ? const SizedBox()
          : RemoveToPadding(
              child: _TopNavigationContainer(
                isNotSinglePage: isNotSinglePage,
                onPopPage: onPopPage,
                pages: pages,
                onBarrierTap: onBarrierTap,
              ),
            ),
    );
  }
}

class RemoveToPadding extends StatelessWidget {
  const RemoveToPadding({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData baseMediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: baseMediaQuery.copyWith(
        padding: baseMediaQuery.padding.copyWith(top: 0),
      ),
      child: child,
    );
  }
}

class _CompactLayout extends StatelessWidget {
  const _CompactLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplitViewState splitViewState = SplitViewScope.of(context);
    return _NavigatorContainer(
      navigatorKey: splitViewState._compactNavigatorKey,
      onPopPage: splitViewState._onPopPage,
      pages: splitViewState._internalState.compactPages
          .map((_PageNode e) => e._page)
          .toList(),
    );
  }
}

class _SplitLayout extends StatelessWidget {
  const _SplitLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SplitViewState splitViewState = SplitViewScope.of(context);
    final double draggableDividerWidth =
        splitViewState.widget.config.draggableDividerWidth;
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRect(
              child: Container(
                child: _NavigatorContainer(
                  navigatorKey: splitViewState._leftNavigatorKey,
                  onPopPage: splitViewState._onPopPage,
                  pages: splitViewState._leftPages
                      .map((_PageNode e) => e._page)
                      .toList(),
                ),
                constraints: BoxConstraints.expand(
                  width: splitViewState._internalState.leftContainerWidth,
                ),
              ),
            ),
            if (splitViewState._leftPages.isNotEmpty ||
                splitViewState._rightPages.isNotEmpty)
              ConstrainedBox(
                constraints: const BoxConstraints.expand(width: 1),
                child: ColoredBox(
                  color: splitViewState.widget.config.draggableDividerColor,
                ),
              ),
            _RightNavigatorContainer(
              onPopPage: splitViewState._onPopPage,
              pages: splitViewState._rightPages
                  .map((_PageNode e) => e._page)
                  .toList(),
              placeholder:
                  splitViewState._internalState.rightContainerPlaceholder,
            ),
          ],
        ),
        if (splitViewState.widget.config.isDraggableDivider)
          Padding(
            padding: EdgeInsets.only(
              left: splitViewState._internalState.leftContainerWidth -
                  draggableDividerWidth / 2,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(width: draggableDividerWidth),
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeColumn,
                child: Listener(
                  onPointerMove: (PointerMoveEvent event) {
                    splitViewState._internalState.leftContainerWidth =
                        splitViewState.widget.delegate.splitLayoutDelegate
                            .calculateLeftContainerWidth(
                      splitViewState._internalState,
                      event.position.dx,
                    );
                    splitViewState._incrementStateVersion(notify: true);
                  },
                  child: const ColoredBox(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        _AnimatedTopNavigationContainer(
          onPopPage: splitViewState._onPopPage,
          isNotSinglePage: splitViewState._leftPages.isNotEmpty ||
              splitViewState._rightPages.isNotEmpty,
          onBarrierTap: () {
            splitViewState.removeUntil(ContainerType.top, (_) => false);
          },
          pages:
              splitViewState._topPages.map((_PageNode e) => e._page).toList(),
        ),
      ],
    );
  }
}

class _PagesContainer implements PagesContainer {
  final int Function() countFunc;
  final Future<bool> Function() tryPopTopFunc;

  _PagesContainer({
    required this.countFunc,
    required this.tryPopTopFunc,
  });

  @override
  int get count => countFunc.call();

  @override
  Future<bool> tryPopTop() => tryPopTopFunc.call();
}
