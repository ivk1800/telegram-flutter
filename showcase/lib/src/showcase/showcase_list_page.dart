import 'package:flutter/material.dart';
import 'package:showcase/src/showcase/chat_cell/chat_cell_showcase.dart';
import 'package:showcase/src/showcase/message_list/showcase_messages_list_page.dart';
import 'package:showcase/src/showcase_split_view_page.dart';
import 'package:split_view/split_view.dart';

class ShowcaseListPage extends StatefulWidget {
  const ShowcaseListPage({Key? key}) : super(key: key);

  @override
  State<ShowcaseListPage> createState() => _ShowcaseListPageState();
}

class _ShowcaseListPageState extends State<ShowcaseListPage> {
  final List<_ShowcaseData> _showcases = <_ShowcaseData>[
    _ShowcaseData(
      title: 'chat cells',
      routeCallback: (BuildContext context) {
        SplitView.of(context)
          ..popUntilRoot(ContainerType.right)
          ..push(
            key: UniqueKey(),
            builder: (_) {
              return const ChatCellShowCase();
            },
            container: ContainerType.right,
          );
      },
    ),
    _ShowcaseData(
      title: 'messages',
      routeCallback: (BuildContext context) {
        SplitView.of(context)
          ..popUntilRoot(ContainerType.right)
          ..push(
            key: UniqueKey(),
            builder: (_) {
              return const ShowcaseMessageListPage();
            },
            container: ContainerType.right,
          );
      },
    ),
    _ShowcaseData(
      title: 'splitview',
      routeCallback: (BuildContext context) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).push<dynamic>(
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const ShowcaseSplitViewPage(),
          ),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('showcase'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _showcases.length,
        itemBuilder: (BuildContext context, int index) {
          final _ShowcaseData showcaseData = _showcases[index];
          return ListTile(
            onTap: () => showcaseData.routeCallback.call(context),
            title: Text(showcaseData.title),
          );
        },
      ),
    );
  }
}

class _ShowcaseData {
  _ShowcaseData({
    required this.title,
    required this.routeCallback,
  });

  final String title;

  final void Function(BuildContext context) routeCallback;
}
