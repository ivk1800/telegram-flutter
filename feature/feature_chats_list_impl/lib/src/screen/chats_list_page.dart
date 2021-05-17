import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;

import 'chats_list_view_model.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({
    Key? key,
  }) : super(key: key);

  @override
  ChatsListPageState createState() => ChatsListPageState();
}

class ChatsListPageState extends State<ChatsListPage>
    with StateInjectorMixin<ChatsListPage, ChatsListPageState> {
  @j.inject
  late ChatsListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('$index'),
        );
      },
    );
  }
}
