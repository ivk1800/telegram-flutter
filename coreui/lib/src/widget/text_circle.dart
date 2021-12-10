import 'package:flutter/material.dart';

class TextCircle extends StatelessWidget {
  const TextCircle({
    required this.context,
    required this.text,
    required this.color,
    Key? key,
  }) : super(key: key);

  final BuildContext context;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 23, maxHeight: 23),
      child: Align(
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.white,
                  fontSize: 13,
                ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(45),
      ),
    );
  }
}
