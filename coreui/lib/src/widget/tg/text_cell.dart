import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  const TextCell(
      {Key? key,
      required this.title,
      this.titleColor,
      this.subtitle,
      this.leading,
      this.onTap})
      : super(key: key);

  final String title;
  final Color? titleColor;
  final String? subtitle;
  final Widget? leading;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(title,
            style: titleColor != null
                ? Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: titleColor)
                : null),
        subtitle: subtitle != null ? Text(subtitle!) : null,
      );
}
