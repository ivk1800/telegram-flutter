import 'package:flutter/material.dart';

class BlockInteraction extends StatelessWidget {
  const BlockInteraction({
    super.key,
    required this.block,
    required this.child,
    this.canPop = false,
  });

  final bool block;
  final bool canPop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return canPop;
      },
      child: Stack(
        children: <Widget>[
          child,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                child: child,
                opacity: animation,
              );
            },
            child: block
                ? Container(
                    color: Colors.black45,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
