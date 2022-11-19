import 'package:feature_settings_search_api/feature_settings_search_api.dart';
import 'package:flutter/material.dart';

class FakeSettingsSearchScreenFactory implements ISettingsSearchScreenFactory {
  const FakeSettingsSearchScreenFactory();

  @override
  Widget create(SettingsSearchScreenController controller) {
    return const _Page();
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Search')),
    );
  }
}
