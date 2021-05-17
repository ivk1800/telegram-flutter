import 'package:flutter/material.dart';

class TdAppBar extends StatefulWidget implements PreferredSizeWidget {
  TdAppBar({
    Key? key,
    this.title,
    this.bottom,
  })  : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  final Widget? title;
  final PreferredSizeWidget? bottom;

  @override
  _TdAppBarState createState() => _TdAppBarState();

  @override
  final Size preferredSize;
}

class _TdAppBarState extends State<TdAppBar> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _appBarBackgroundColorTween;
  late Animation<Color?> _navigationIconColorTween;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    _appBarBackgroundColorTween =
        ColorTween(begin: Colors.red, end: Colors.white)
            .animate(_animationController);

    _navigationIconColorTween =
        ColorTween(begin: Colors.white, end: Colors.black)
            .animate(_animationController);
  }

  @override
  void didChangeDependencies() {
    _appBarBackgroundColorTween =
        ColorTween(begin: Theme.of(context).primaryColor, end: Colors.white)
            .animate(_animationController);
    _navigationIconColorTween =
        ColorTween(begin: Colors.white, end: Colors.black)
            .animate(_animationController);
    super.didChangeDependencies();
  }

  bool b = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        // return FadeTransition(child: child, opacity: animation,);
        return ScaleTransition(child: child, scale: animation);
      },
      child: b ? _buildFirstAppBar() : _buildSecondsAppBar(),
    );

    return AnimatedBuilder(
      builder: (BuildContext context, Widget? child) {
        return AppBar(
          leading: IconButton(
            color: _navigationIconColorTween.value,
            icon: AnimatedIcon(
              progress: _animationController,
              icon: AnimatedIcons.menu_close,
            ),
            onPressed: () {
              if (_animationController.value == 1.0) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
          ],
          backgroundColor: _appBarBackgroundColorTween.value,
          title: widget.title,
          bottom: widget.bottom,
        );
      },
      animation: _appBarBackgroundColorTween,
    );
  }

  Widget _buildFirstAppBar() {
    return AppBar(
      key: ValueKey(1),
      leading: IconButton(
        // color: _navigationIconColorTween.value,
        icon: AnimatedIcon(
          progress: _animationController,
          icon: AnimatedIcons.menu_close,
        ),
        onPressed: () {
          if (_animationController.value == 1.0) {
            _animationController.reverse();
          } else {
            _animationController.forward();
          }
          setState(() {
            b = !b;
          });
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ],
      backgroundColor: Theme.of(context).primaryColor,
      title: widget.title,
      bottom: widget.bottom,
    );
  }

  Widget _buildSecondsAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.grey),
      key: ValueKey(2),
      leading: IconButton(
        // color: _navigationIconColorTween.value,
        icon: AnimatedIcon(
          progress: _animationController,
          icon: AnimatedIcons.menu_close,
        ),
        onPressed: () {
          if (_animationController.value == 1.0) {
            _animationController.reverse();
          } else {
            _animationController.forward();
          }
          setState(() {
            b = !b;
          });
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.push_pin_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.volume_off),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.restore_from_trash_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert_outlined),
          onPressed: () {},
        ),
      ],
      backgroundColor: Colors.white,
      title: Text(
        "1",
        style: TextStyle(color: Colors.grey),
      ),
      bottom: widget.bottom,
    );
  }
}
