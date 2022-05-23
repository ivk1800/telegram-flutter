import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FakeChatsListScreenFactory implements IChatsListScreenFactory {
  const FakeChatsListScreenFactory();

  @override
  Widget create() {
    return const Center(child: Text('FakeChatsListScreen'));
  }
}
