import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:flutter/material.dart';

class FakeChatsListScreenFactory implements IChatsListScreenFactory {
  const FakeChatsListScreenFactory();

  @override
  Widget create() {
    return const _Page();
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => _PageState();
}

class _PageState extends State<_Page> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('FakeChatsListScreen'),
        const SizedBox(height: 16),
        Text('$_count'),
        OutlinedButton(
          child: const Text('inc'),
          onPressed: () {
            setState(() {
              _count++;
            });
          },
        )
      ],
    );
  }
}
