import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  const TextCell(
      {Key? key,
      required this.title,
      this.titleColor,
      this.subtitle,
      this.valueWidget,
      this.leading,
      this.onTap})
      : super(key: key);

  factory TextCell.textValue({
    required String value,
    required String title,
    Color? titleColor,
    String? subtitle,
    Widget? leading,
    GestureTapCallback? onTap,
  }) {
    return TextCell(
      title: title,
      titleColor: titleColor,
      subtitle: subtitle,
      valueWidget: Builder(
        builder: (BuildContext context) {
          return Text(
            value,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: Theme.of(context).accentColor),
          );
        },
      ),
      leading: leading,
      onTap: onTap,
    );
  }

  factory TextCell.toggle({
    required bool value,
    required String title,
    required ValueChanged<bool> onChanged,
    Color? titleColor,
    String? subtitle,
    Widget? leading,
    GestureTapCallback? onTap,
  }) {
    return TextCell(
      title: title,
      titleColor: titleColor,
      subtitle: subtitle,
      valueWidget: Switch(
        value: value,
        onChanged: onChanged,
      ),
      leading: leading,
      onTap: onTap,
    );
  }

  final String title;
  final Color? titleColor;
  final String? subtitle;
  final Widget? valueWidget;
  final Widget? leading;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        onTap: onTap,
        leading: leading,
        trailing: valueWidget,
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
