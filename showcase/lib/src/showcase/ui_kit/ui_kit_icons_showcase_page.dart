import 'package:flutter/material.dart';
import 'package:tg_ui_kit/tg_ui_kit.dart';

class UiKitIconsShowcasePage extends StatelessWidget {
  const UiKitIconsShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icons')),
      body: SingleChildScrollView(
        child: Column(
          children: TgIcons.all.keys.map<Widget>(
            (String key) {
              return ListTile(
                leading: ColoredBox(
                  color: Colors.transparent,
                  child: Icon(TgIcons.all[key]),
                ),
                title: Text(key),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
