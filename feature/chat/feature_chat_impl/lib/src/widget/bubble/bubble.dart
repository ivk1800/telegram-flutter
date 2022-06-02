import 'package:flutter/material.dart';

import 'bubble_clipper.dart';

class Bubble extends StatelessWidget {
  const Bubble({super.key, required this.child, required this.radius});

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: ClipPath(
        clipper: BubbleClipper(
          radius: radius,
        ),
        child: child,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.1,
            blurRadius: 3,
          ),
        ],
      ),
    );
  }
}
