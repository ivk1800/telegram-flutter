import 'package:flutter/material.dart';

typedef AppBarBuilder = Widget Function(
  AnimationController animationController,
  BuildContext context, {
  required bool isActive,
});

class TgSwitchedAppBar extends StatefulWidget implements PreferredSizeWidget {
  TgSwitchedAppBar({
    super.key,
    required this.appBarBuilder,
    this.bottom,
    this.backgroundColor = Colors.transparent,
  }) : preferredSize = Size.fromHeight(
          kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
        );

  final AppBarBuilder? appBarBuilder;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;

  @override
  TgSwitchedAppBarState createState() => TgSwitchedAppBarState();

  @override
  final Size preferredSize;
}

class TgSwitchedAppBarState extends State<TgSwitchedAppBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  bool _isActive = false;

  void setActive({required bool active}) {
    setState(() {
      _isActive = active;
      if (_isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
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
    return ColoredBox(
      color: widget.backgroundColor ?? Theme.of(context).primaryColor,
      child: AnimatedSwitcher(
        duration: _animationDuration,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            child: child,
            opacity: animation,
          );
        },
        child: widget.appBarBuilder!
            .call(_animationController, context, isActive: _isActive),
      ),
    );
  }

  static const Duration _animationDuration = Duration(milliseconds: 200);
}
