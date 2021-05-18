import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SplitView extends StatefulWidget {
  const SplitView({
    required this.rightContainerPlaceholderBuilder,
    required this.leftContainerInitialWidgetBuilder,
    Key? key,
  }) : super(key: key);

  final WidgetBuilder rightContainerPlaceholderBuilder;
  final WidgetBuilder leftContainerInitialWidgetBuilder;

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
      : timestamp = order ?? DateTime.now().millisecondsSinceEpoch;

  final ContainerType container;
  final int timestamp;

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
    _leftRootPage = _PageNode(
        order: 0,
        container: ContainerType.Left,
        page: _SimplePage(
            builder: widget.leftContainerInitialWidgetBuilder,
            containerType: ContainerType.Left,
            key: UniqueKey()));

    _rightRootPage = _PageNode(
        order: -1,
        container: ContainerType.Left,
        page: _SimplePage(
            builder: widget.rightContainerPlaceholderBuilder,
            containerType: ContainerType.Right,
            key: UniqueKey()));

    _leftPages = <_PageNode>[_leftRootPage];
    _rightPages = <_PageNode>[_rightRootPage];
    _topPages = <_PageNode>[];
  }

  void push(WidgetBuilder builder, ContainerType containerType) {
    setState(() {
      switch (containerType) {
        case ContainerType.Left:
          _leftPages.add(_PageNode(
              container: containerType,
              page: _SimplePage(
                  builder: builder,
                  containerType: containerType,
                  key: UniqueKey())));
          break;
        case ContainerType.Right:
          _rightPages.add(_PageNode(
              container: containerType,
              page: _SimplePage(
                  builder: builder,
                  containerType: containerType,
                  key: UniqueKey())));
          break;
        case ContainerType.Top:
          _topPages.add(_PageNode(
              container: containerType,
              page: _SimplePage(
                  builder: builder,
                  containerType: containerType,
                  key: UniqueKey())));
          break;
      }
      _invalidatePages();
    });
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
        ..sort(
            (_PageNode a, _PageNode b) => a.timestamp.compareTo(b.timestamp));
    } else {
      _compactPages = const <_PageNode>[];
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
                setState(() {
                  _topPages.clear();
                });
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
