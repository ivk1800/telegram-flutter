import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  const TextCell({
    super.key,
    required this.title,
    this.titleColor,
    this.subtitle,
    this.valueWidget,
    this.leading,
    this.onTap,
  });

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
                ?.copyWith(color: Theme.of(context).colorScheme.secondary),
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
      valueWidget: onTap != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const VerticalDivider(),
                Switch(
                  value: value,
                  onChanged: onChanged,
                ),
              ],
            )
          : Switch(
              value: value,
              onChanged: onChanged,
            ),
      leading: leading,
      onTap: onTap ??
          () {
            onChanged(!value);
          },
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
        title: Text(
          title,
          style: titleColor != null
              ? Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: titleColor)
              : null,
        ),
        subtitle: subtitle != null ? Text(subtitle!) : null,
      );
}
