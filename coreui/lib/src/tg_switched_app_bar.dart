import 'package:flutter/material.dart';

typedef ActionWidgetsBuilder = List<Widget> Function(
    BuildContext context, bool isAcive);
typedef WidgetBuilder = Widget Function(BuildContext context, bool isAcive);
typedef LeadingIconProvider = AnimatedIconData Function(bool isActive);
typedef ColorProvider = Color Function(bool isActive);

class TgSwitchedAppBar extends StatefulWidget implements PreferredSizeWidget {
  TgSwitchedAppBar({
    Key? key,
    this.title,
    required this.leadingIconProvider,
    required this.navigationIconTap,
    required this.iconColorProvider,
    required this.backgroundColorProvider,
    required this.titleBuilder,
    required this.actionWidgetsBuilder,
    this.bottom,
  })  : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  final WidgetBuilder titleBuilder;
  final ColorProvider backgroundColorProvider;
  final ColorProvider iconColorProvider;
  final VoidCallback navigationIconTap;
  final ActionWidgetsBuilder actionWidgetsBuilder;
  final LeadingIconProvider leadingIconProvider;
  final Widget? title;
  final PreferredSizeWidget? bottom;

  @override
  TgSwitchedAppBarState createState() => TgSwitchedAppBarState();

  @override
  final Size preferredSize;
}

class TgSwitchedAppBarState extends State<TgSwitchedAppBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  bool _isActive = false;

  void setActive(bool value) {
    if (_isActive) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isActive = value;
    });
  }

  bool get isActive => _isActive;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        widget.backgroundColorProvider.call(_isActive);
    return AnimatedSwitcher(
        duration: _animationDuration,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            child: child,
            opacity: animation,
          );
        },
        child: _buildAppBar(
          key: ValueKey<Color>(backgroundColor),
          context: context,
          // TODO support theme switching
          iconsColor: widget.iconColorProvider.call(_isActive),
          backgroundColor: backgroundColor,
          // iconsColor: !_isActive ? Colors.white : Colors.grey,
          // backgroundColor:
          //     !_isActive ? Theme.of(context).primaryColor : Colors.white,
        ));
  }

  Widget _buildAppBar(
      {required Key key,
      required BuildContext context,
      required Color backgroundColor,
      required Color iconsColor}) {
    return AppBar(
        iconTheme: IconThemeData(color: iconsColor),
        key: key,
        leading: IconButton(
          // color: _navigationIconColorTween.value,
          icon: AnimatedIcon(
            progress: _animationController,
            icon: widget.leadingIconProvider.call(_isActive),
          ),
          onPressed: widget.navigationIconTap,
        ),
        title: widget.titleBuilder.call(context, _isActive),
        actions: widget.actionWidgetsBuilder.call(context, _isActive),
        bottom: widget.bottom,
        backgroundColor: backgroundColor);
  }

  static const Duration _animationDuration = Duration(milliseconds: 200);
}
