import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShortInfoFactory {
  Widget create(BuildContext context) {
    return Text(
      'todo',
      style: Theme.of(context).textTheme.caption,
    );
  }
}
