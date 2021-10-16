import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({
    Key? key,
    required this.animationController,
    required this.searchQueryController,
    required this.onLeadingTap,
    required this.focusNode,
    this.isOverrideLeading = true,
  }) : super(key: key);

  final AnimationController animationController;
  final VoidCallback onLeadingTap;
  final FocusNode focusNode;
  final bool isOverrideLeading;
  final TextEditingController searchQueryController;

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar>
    with TickerProviderStateMixin {
  bool _showClearButtonQuery = false;
  late Animation<Size?> _clearIconTween;
  late AnimationController _animationController;

  TextEditingController get _searchQueryController =>
      widget.searchQueryController;

  @override
  void initState() {
    super.initState();
    _searchQueryController.addListener(_onSearchEvent);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _clearIconTween = SizeTween(begin: Size.zero, end: const Size(1, 1))
        .animate(_animationController);
  }

  void _onSearchEvent() {
    setState(() {
      final bool _prevValue = _showClearButtonQuery;
      _showClearButtonQuery = _searchQueryController.text.isNotEmpty;
      if (_showClearButtonQuery != _prevValue) {
        if (_showClearButtonQuery) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    });
  }

  @override
  void dispose() {
    _searchQueryController.removeListener(_onSearchEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: widget.isOverrideLeading
          ? IconButton(
              icon: AnimatedIcon(
                progress: widget.animationController,
                icon: AnimatedIcons.menu_arrow,
              ),
              onPressed: widget.onLeadingTap,
            )
          : null,
      title: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        focusNode: widget.focusNode,
        controller: _searchQueryController,
        decoration: const InputDecoration.collapsed(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
        AnimatedBuilder(
          animation: _clearIconTween,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: _clearIconTween.value!.height,
              child: child,
            );
          },
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _searchQueryController.text = '';
            },
          ),
        ),
      ],
    );
  }
}
