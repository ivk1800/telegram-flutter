import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SplitView extends StatefulWidget {
  const SplitView({
    required this.rightContainerPlaceholderBuilder,
    Key? key,
  }) : super(key: key);

  final WidgetBuilder rightContainerPlaceholderBuilder;

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

enum ContainerType { Left, Right, Top }

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

  late _PageNode _leftRootPage;
  late _PageNode _rightRootPage;

  late List<_PageNode> _compactPages = const <_PageNode>[];
  bool _isCompact = false;

  double _leftContainerWidth = 450;

  @override
  void initState() {
    super.initState();
    _leftRootPage = _createLeftRootPage(Container());

    _rightRootPage = _PageNode(
        order: RightRootPageIndex,
        container: ContainerType.Left,
        page: _SimplePage(
            builder: widget.rightContainerPlaceholderBuilder,
            containerType: ContainerType.Right,
            key: UniqueKey()));

    _leftPages = <_PageNode>[_leftRootPage];
    _rightPages = <_PageNode>[_rightRootPage];
    _topPages = <_PageNode>[];
  }

  void popUntilRoot(ContainerType container) {
    setState(() {
      switch (container) {
        case ContainerType.Left:
          _leftPages.removeWhere(
              (_PageNode element) => element.order != LeftRootPageIndex);
          break;
        case ContainerType.Right:
          _rightPages.removeWhere(
              (_PageNode element) => element.order != RightRootPageIndex);
          break;
        case ContainerType.Top:
          _topPages.clear();
          break;
      }
      _invalidatePages();
    });
  }

  void pushAllReplacement(
      {required LocalKey key,
      required WidgetBuilder builder,
      required ContainerType container}) {
    setState(() {
      popUntilRoot(container);
      push(key: key, builder: builder, container: container);
      _invalidatePages();
    });
  }

  void setLeftRootPage(Widget widget) {
    setState(() {
      _leftRootPage = _createLeftRootPage(widget);
      final int indexOfRootPage = _leftPages.indexOf(_leftPages.firstWhere(
          (_PageNode element) => element.order == LeftRootPageIndex));
      _leftPages[indexOfRootPage] = _leftRootPage;
      _invalidatePages();
    });
  }

  void push(
      {required LocalKey key,
      required WidgetBuilder builder,
      required ContainerType container}) {
    _push(_SimplePage(key: key, builder: builder, containerType: container),
        container);
  }

  void _push(MyPage<dynamic> page, ContainerType containerType) {
    setState(() {
      switch (containerType) {
        case ContainerType.Left:
          _leftPages.add(_PageNode(container: containerType, page: page));
          break;
        case ContainerType.Right:
          _rightPages.add(_PageNode(container: containerType, page: page));
          break;
        case ContainerType.Top:
          _topPages.add(_PageNode(container: containerType, page: page));
          break;
      }
      _invalidatePages();
    });
  }

  _PageNode _createLeftRootPage(Widget widget) {
    return _PageNode(
        order: LeftRootPageIndex,
        container: ContainerType.Left,
        page: _SimplePage(
            builder: (_) => widget,
            containerType: ContainerType.Left,
            key: UniqueKey()));
  }

  void _onWidthChanged(double width) {
    if (width <= 500) {
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
        ..removeWhere((_PageNode element) => element == _rightRootPage)
        ..sort((_PageNode a, _PageNode b) => a.order.compareTo(b.order));
    } else {
      _compactPages = const <_PageNode>[];
    }
  }

  bool hasKey(LocalKey key, ContainerType container) {
    switch (container) {
      case ContainerType.Left:
        return _leftPages.hasKey(key);
      case ContainerType.Right:
        return _rightPages.hasKey(key);
      case ContainerType.Top:
        return _topPages.hasKey(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _onWidthChanged(constraints.maxWidth);
        Widget finalWidget;
        if (constraints.maxWidth > 500) {
          if (_topPages.isNotEmpty) {
            finalWidget = _buildAllContainersTogether(context);
          } else {
            finalWidget = _buildLeftAndRightContainersTogether(context);
          }
        } else {
          finalWidget = _buildCompactContainer(context);
        }
        return finalWidget;
      },
    );
  }

  Widget _buildTopContainer(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                popUntilRoot(ContainerType.Top);
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints:
                    const BoxConstraints(maxHeight: 600, maxWidth: 500),
                padding: const EdgeInsets.only(top: 48, bottom: 48),
                child: ClipRect(
                  child: _buildNavigator(<Page<dynamic>>[
                        _SimplePage(
                            key: UniqueKey(),
                            builder: widget.rightContainerPlaceholderBuilder,
                            containerType: ContainerType.Right)
                      ] +
                      _topPages.map((_PageNode e) => e.page).toList()),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildAllContainersTogether(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildLeftAndRightContainersTogether(context),
        _buildTopContainer(context)
      ],
    );
  }

  Widget _buildLeftAndRightContainersTogether(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: _buildLeftContainer(context),
          constraints: BoxConstraints.expand(width: _leftContainerWidth),
        ),
        _buildDragableDivider(),
        _buildRightContainer(context)
      ],
    );
  }

  Widget _buildDragableDivider() {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: Listener(
        onPointerMove: (PointerMoveEvent event) {
          setState(() {
            _leftContainerWidth = event.position.dx;
          });
        },
        child: Container(
          color: Colors.transparent,
          constraints:
              const BoxConstraints.expand(width: 3, height: double.infinity),
          child: Row(
            children: [
              Container(
                color: Colors.grey,
                width: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftContainer(BuildContext context) {
    assert(_leftPages.isNotEmpty);
    return _buildNavigator(_leftPages.map((_PageNode e) => e.page).toList());
  }

  Widget _buildCompactContainer(BuildContext context) {
    assert(_compactPages.isNotEmpty);
    return _buildNavigator(_compactPages.map((_PageNode e) => e.page).toList());
  }

  Widget _buildRightContainer(BuildContext context) {
    assert(_rightPages.isNotEmpty);
    return Expanded(
        child: ClipRect(
      child: _buildNavigator(_rightPages.map((_PageNode e) => e.page).toList()),
    ));
  }

  Widget _buildNavigator(List<Page<dynamic>> pages) {
    return Navigator(
      pages: pages,
      onPopPage: (Route<dynamic> route, dynamic result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (route.settings is MyPage) {
          setState(() {
            final MyPage<dynamic> myPage = route.settings as MyPage<dynamic>;
            switch (myPage.container) {
              case ContainerType.Left:
                final _PageNode lastWhere = _leftPages.lastWhere(
                    (_PageNode element) =>
                        element.container == ContainerType.Left);
                _leftPages.remove(lastWhere);
                break;
              case ContainerType.Right:
                final _PageNode lastWhere = _rightPages.lastWhere(
                    (_PageNode element) =>
                        element.container == ContainerType.Right);
                _rightPages.remove(lastWhere);
                break;
              case ContainerType.Top:
                final _PageNode lastWhere = _topPages.lastWhere(
                    (_PageNode element) =>
                        element.container == ContainerType.Top);
                _topPages.remove(lastWhere);
                break;
            }
            _invalidatePages();
          });
        }

        return true;
      },
    );
  }

  static const int LeftRootPageIndex = 0;
  static const int RightRootPageIndex = -1;
}

abstract class MyPage<T> extends Page<T> {
  const MyPage({
    required LocalKey key,
    required this.container,
  }) : super(key: key);

  final ContainerType container;
}

class _SimplePage extends MyPage<dynamic> {
  const _SimplePage({
    required this.builder,
    required ContainerType containerType,
    required LocalKey key,
  }) : super(key: key, container: containerType);

  final WidgetBuilder builder;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return MaterialPageRoute<dynamic>(
        settings: this,
        builder: (BuildContext context) => builder.call(context));
  }
}

extension _Extensions on List<_PageNode> {
  bool hasKey(LocalKey key) =>
      any((_PageNode element) => element.page.key == key);
}
