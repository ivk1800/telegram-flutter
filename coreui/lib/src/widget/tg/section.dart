import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  const Section({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
      );
}
