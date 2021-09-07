import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'container_divider.dart';

class Config {
  const Config({
    required this.leftContainerWidth,
    required this.minLeftContainerWidth,
    required this.maxLeftContainerWidth,
    required this.minRightContainerWidth,
    required this.maxCompactWidth,
    required this.isDraggableDivider,
  });

  final double leftContainerWidth;
  final double minLeftContainerWidth;
  final double maxLeftContainerWidth;
  final double minRightContainerWidth;
  final double maxCompactWidth;

  final bool isDraggableDivider;
}

class SplitView extends StatefulWidget {
  const SplitView({
    this.config = const Config(
      minLeftContainerWidth: 290,
      leftContainerWidth: 350,
      maxLeftContainerWidth: 400,
      isDraggableDivider: true,
      minRightContainerWidth: 500,
      maxCompactWidth: 699,
    ),
    Key? key,
  }) : super(key: key);

  final Config config;

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

enum ContainerType { left, right, top }

class _PageNode {
  _PageNode({required this.container, required this.page, int? order})
      : order = order ?? DateTime.now().millisecondsSinceEpoch;

  final ContainerType container;
  final int order;

  final Page<dynamic> page;
}

class SplitViewState extends State<SplitView> {
  late List<_PageNode> _leftPages;
  late List<_PageNode> _rightPages;
  late List<_PageNode> _topPages;

  final GlobalKey<NavigatorState> _topNavigatorKey =
      GlobalKey<NavigatorState>();

  _PageNode? _leftRootPage;
  Widget _rightContainerPlaceholder = Container();

  late List<_PageNode> _compactPages = const <_PageNode>[];
  bool _isCompact = false;

  double _leftContainerWidth = 0;

  @override
  void initState() {
    super.initState();
    _leftContainerWidth = widget.config.leftContainerWidth;

    _leftPages = <_PageNode>[];
    _rightPages = <_PageNode>[];
    _topPages = <_PageNode>[];
  }

  void popUntilRoot(ContainerType container) {
    setState(() {
      switch (container) {
        case ContainerType.left:
          _leftPages.removeWhere(
            (_PageNode element) => element.order != kLeftRootPageIndex,
          );
          break;
        case ContainerType.right:
          _rightPages.removeWhere(
            (_PageNode element) => element.order != kRightRootPageIndex,
          );
          break;
        case ContainerType.top:
          _topPages.clear();
          break;
      }
      _invalidatePages();
    });
  }

  bool _removeTop(ContainerType container) {
    bool _tryRemoveTop(List<_PageNode> pages) {
      if (pages.isNotEmpty) {
        pages.removeLast();
        return true;
      } else {
        return false;
      }
    }

    switch (container) {
      case ContainerType.left:
        return _tryRemoveTop(_leftPages);
      case ContainerType.right:
        return _tryRemoveTop(_rightPages);
      case ContainerType.top:
        return _tryRemoveTop(_topPages);
    }
  }

  void pushAllReplacement({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  }) {
    setState(() {
      popUntilRoot(container);
      push(key: key, builder: builder, container: container);
      _invalidatePages();
    });
  }

  void setLeftRootPage(Widget widget) {
    setState(() {
      if (_leftRootPage == null) {
        _leftRootPage = _createLeftRootPage(widget);
        _leftPages.add(_leftRootPage!);
      } else {
        _leftRootPage = _createLeftRootPage(widget);
        final int indexOfRootPage = _leftPages.indexOf(_leftPages.firstWhere(
          (_PageNode element) => element.order == kLeftRootPageIndex,
        ));
        _leftPages[indexOfRootPage] = _leftRootPage!;
      }
      _invalidatePages();
    });
  }

  void push({
    required LocalKey key,
    required WidgetBuilder builder,
    required ContainerType container,
  }) {
    _push(
      _SimplePage(
        key: key,
        animateRouterProvider: () => _shouldAnimate(key, container),
        builder: builder,
        containerType: container,
      ),
      container,
    );
  }

  void setRightContainerPlaceholder(Widget widget) {
    setState(() {
      _rightContainerPlaceholder = widget;
    });
  }

  void _push(MyPage<dynamic> page, ContainerType containerType) {
    setState(() {
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
      _invalidatePages();
    });
  }

  _PageNode _createLeftRootPage(Widget widget) {
    final UniqueKey key = UniqueKey();
    return _PageNode(
      order: kLeftRootPageIndex,
      container: ContainerType.left,
      page: _SimplePage(
        builder: (_) => widget,
        animateRouterProvider: () => _shouldAnimate(key, ContainerType.left),
        containerType: ContainerType.left,
        key: key,
      ),
    );
  }

  void _onWidthChanged(double width) {
    if (width <= widget.config.maxCompactWidth) {
      if (!_isCompact) {
        _isCompact = true;
        _invalidatePages();
      }
    } else {
      if (_isCompact) {
        _isCompact = false;
        _invalidatePages();
      }
    }
  }

  void _invalidatePages() {
    if (_isCompact) {
      _compactPages = (_leftPages + _rightPages + _topPages)
        // todo fix order if first pushed top
        ..sort((_PageNode a, _PageNode b) => a.order.compareTo(b.order));
    } else {
      _compactPages = const <_PageNode>[];
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: _buildAdaptiveWidget(),
      onWillPop: () async {
        if (_isCompact) {
          return !(await _topNavigatorKey.currentState!.maybePop());
        }

        if (_topPages.isNotEmpty) {
          if (_leftPages.isEmpty && _rightPages.isEmpty) {
            return true;
          } else {
            setState(() {
              _topPages.removeLast();
            });
          }
          return false;
        } else if (_rightPages.isNotEmpty) {
          setState(() {
            _rightPages.removeLast();
          });
          return false;
        } else if (_leftPages.isNotEmpty) {
          // first node is root page
          if (_leftPages.length == 1) {
            return true;
          } else {
            setState(() {
              _leftPages.removeLast();
            });
          }
          return false;
        }
        return true;
      },
    );
  }

  Widget _buildAdaptiveWidget() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _onWidthChanged(constraints.maxWidth);
        Widget finalWidget;
        if (constraints.maxWidth > widget.config.maxCompactWidth) {
          finalWidget = _buildAllContainersTogether(context);
        } else {
          finalWidget = _buildCompactContainer(context);
        }
        return finalWidget;
      },
    );
  }

  Widget _buildTopContainer(Key key, BuildContext context) {
    final bool isNotSinglePage =
        _leftPages.isNotEmpty || _rightPages.isNotEmpty;
    return Align(
      key: key,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (isNotSinglePage) {
                popUntilRoot(ContainerType.top);
              }
            },
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Align(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 600, maxWidth: 500),
              padding: const EdgeInsets.only(top: 48, bottom: 48),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 40,
                child: ClipRect(
                  child: _buildNavigator(<Page<dynamic>>[
                        // add stub page for trigger navigation button
                        if (isNotSinglePage)
                          _SimplePage(
                            key: UniqueKey(),
                            animateRouterProvider: () => false,
                            builder: (_) => Container(),
                            containerType: ContainerType.top,
                          ),
                      ] +
                      _topPages.map((_PageNode e) => e.page).toList()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllContainersTogether(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildLeftAndRightContainersTogether(context),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              child: child,
              opacity: animation,
            );
          },
          // TODO rename keys
          child: _topPages.isEmpty
              ? const SizedBox(
                  key: ValueKey<dynamic>('hide'),
                )
              : wrapWithoutTopPadding(
                  _buildTopContainer(const ValueKey<dynamic>('show'), context),
                ),
        ),
      ],
    );
  }

  Widget wrapWithoutTopPadding(Widget child) {
    final MediaQueryData baseMediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: baseMediaQuery.copyWith(
        padding: baseMediaQuery.padding.copyWith(top: 0),
      ),
      child: child,
    );
  }

  Widget _buildLeftAndRightContainersTogether(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: <Widget>[
            ClipRect(
              child: Container(
                child: _buildLeftContainer(context),
                constraints: BoxConstraints.expand(width: _leftContainerWidth),
              ),
            ),
            if (_leftPages.isNotEmpty || _rightPages.isNotEmpty)
              _buildDraggableDivider(constraints.maxWidth),
            _buildRightContainer(context),
          ],
        );
      },
    );
  }

  Widget _buildDraggableDivider(double maxWidth) {
    final Container divider = Container(
      color: Colors.transparent,
      constraints:
          const BoxConstraints.expand(width: 3, height: double.infinity),
      child: const ContainerDivider(),
    );
    if (widget.config.isDraggableDivider) {
      return MouseRegion(
        cursor: SystemMouseCursors.resizeColumn,
        child: Listener(
          onPointerMove: (PointerMoveEvent event) {
            setState(() {
              _leftContainerWidth = event.position.dx.clamp(
                widget.config.minLeftContainerWidth,
                widget.config.maxLeftContainerWidth,
              );
            });
          },
          child: divider,
        ),
      );
    }
    return divider;
  }

  Widget _buildLeftContainer(BuildContext context) {
    if (_leftPages.isEmpty) {
      return const SizedBox();
    }
    return _buildNavigator(_leftPages.map((_PageNode e) => e.page).toList());
  }

  Widget _buildCompactContainer(BuildContext context) {
    if (_compactPages.isEmpty) {
      return const SizedBox();
    }
    return _buildNavigator(
      _compactPages.map((_PageNode e) => e.page).toList(),
      key: _topNavigatorKey,
    );
  }

  Widget _buildRightContainer(BuildContext context) {
    if (_rightPages.isEmpty) {
      return Expanded(child: _rightContainerPlaceholder);
    }
    final List<Page<dynamic>> pages =
        _rightPages.map((_PageNode e) => e.page).toList();
    final UniqueKey key = UniqueKey();
    return Expanded(
      child: ClipRect(
        child: _buildNavigator(
          <Page<dynamic>>[
                // add stub page for trigger navigation button
                _SimplePage(
                  key: key,
                  animateRouterProvider: () =>
                      _shouldAnimate(key, ContainerType.top),
                  builder: (_) => Container(),
                  containerType: ContainerType.top,
                ),
              ] +
              pages,
        ),
      ),
    );
  }

  bool _shouldAnimate(LocalKey key, ContainerType container) {
    bool shouldAnimate(List<_PageNode> pages) {
      final int indexWhere =
          pages.indexWhere((_PageNode element) => element.page.key == key);
      return indexWhere > 0;
    }

    if (_isCompact) {
      return shouldAnimate(_compactPages);
    }
    switch (container) {
      case ContainerType.left:
        return shouldAnimate(_leftPages);
      case ContainerType.right:
        return shouldAnimate(_rightPages);
      case ContainerType.top:
        return shouldAnimate(_topPages);
    }
  }

  Widget _buildNavigator(
    List<Page<dynamic>> pages, {
    Key? key,
  }) {
    return Navigator(
      key: key,
      pages: pages,
      onPopPage: (Route<dynamic> route, Object? result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (route.settings is MyPage) {
          setState(() {
            final MyPage<dynamic> myPage = route.settings as MyPage<dynamic>;
            _removeTopFromContainer(myPage.container);
            _invalidatePages();
          });
        }

        return true;
      },
    );
  }

  void _removeTopFromContainer(ContainerType container) {
    switch (container) {
      case ContainerType.left:
        final _PageNode lastWhere = _leftPages.lastWhere(
          (_PageNode element) => element.container == ContainerType.left,
        );
        _leftPages.remove(lastWhere);
        break;
      case ContainerType.right:
        final _PageNode lastWhere = _rightPages.lastWhere(
          (_PageNode element) => element.container == ContainerType.right,
        );
        _rightPages.remove(lastWhere);
        break;
      case ContainerType.top:
        final _PageNode lastWhere = _topPages.lastWhere(
          (_PageNode element) => element.container == ContainerType.top,
        );
        _topPages.remove(lastWhere);
        break;
    }
  }

  static const int kLeftRootPageIndex = 0;
  static const int kRightRootPageIndex = -1;
}

abstract class MyPage<T> extends Page<T> {
  const MyPage({
    required LocalKey key,
    required this.container,
  }) : super(key: key);

  final ContainerType container;
}

typedef _AnimateRouterProvider = bool Function();

class _SimplePage extends MyPage<dynamic> {
  const _SimplePage({
    required this.builder,
    required this.animateRouterProvider,
    required ContainerType containerType,
    required LocalKey key,
  }) : super(key: key, container: containerType);

  final WidgetBuilder builder;
  final _AnimateRouterProvider animateRouterProvider;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return _DefaultRoute<dynamic>(
      settings: this,
      routerDurationProvider: () {
        if (!animateRouterProvider()) {
          return Duration.zero;
        }
        return null;
      },
      builder: builder.call,
    );
  }
}

typedef _RouterDurationProvider = Duration? Function();

class _DefaultRoute<T> extends MaterialPageRoute<T> {
  _DefaultRoute({
    required RouteSettings? settings,
    required WidgetBuilder builder,
    required this.routerDurationProvider,
  }) : super(builder: builder, settings: settings);

  final _RouterDurationProvider routerDurationProvider;

  @override
  Duration get transitionDuration {
    return routerDurationProvider() ?? super.transitionDuration;
  }

  @override
  Duration get reverseTransitionDuration {
    return routerDurationProvider() ?? super.reverseTransitionDuration;
  }
}

extension _Extensions on List<_PageNode> {
  bool hasKey(LocalKey key) =>
      any((_PageNode element) => element.page.key == key);
}
