import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';

class UnreadMessagesCount extends StatefulWidget {
  const UnreadMessagesCount({
    required this.count,
    required this.isMuted,
    Key? key,
  }) : super(key: key);

  final int count;
  final bool isMuted;

  @override
  State<UnreadMessagesCount> createState() => _UnreadMessagesCountState();
}

class _UnreadMessagesCountState extends State<UnreadMessagesCount>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 1.1)
              .chain(CurveTween(curve: Curves.bounceInOut)),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.1, end: 1.0)
              .chain(CurveTween(curve: Curves.bounceInOut)),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant UnreadMessagesCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != oldWidget.count) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: TextCircle(
        context: context,
        text: '${widget.count}',
        color: widget.isMuted
            ? Colors.blueGrey
            : Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
