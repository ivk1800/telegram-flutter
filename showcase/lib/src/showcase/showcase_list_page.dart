import 'package:flutter/material.dart';
import 'package:showcase/src/showcase/chat_cell/chat_cell_showcase.dart';
import 'package:showcase/src/showcase/showcase_scope.dart';
import 'package:showcase/src/showcase_messages_list_page.dart';
import 'package:showcase/src/showcase_split_view_page.dart';
import 'package:split_view/split_view.dart';

class ShowcaseListPage extends StatefulWidget {
  const ShowcaseListPage({super.key});

  @override
  State<ShowcaseListPage> createState() => _ShowcaseListPageState();
}

class _ShowcaseListPageState extends State<ShowcaseListPage> {
  final List<_ShowcaseData> _showcases = <_ShowcaseData>[
    _ShowcaseData(
      title: 'chat cells',
      routeCallback: (BuildContext context) {
        SplitView.of(context)
          ..removeUntil(ContainerType.right, (_) => false)
          ..add(
            key: UniqueKey(),
            builder: (_) {
              return const ChatCellShowCase();
            },
            container: ContainerType.right,
          );
      },
    ),
    _ShowcaseData(
      title: 'avatar',
      routeCallback: (BuildContext context) {
        final Widget widget =
            ShowcaseScope.getAvatarShowcaseFactory(context).create(context);

        SplitView.of(context)
          ..removeUntil(ContainerType.right, (_) => false)
          ..add(
            key: UniqueKey(),
            builder: (_) => widget,
            container: ContainerType.right,
          );
      },
    ),
    _ShowcaseData(
      title: 'messages',
      routeCallback: (BuildContext context) {
        SplitView.of(context)
          ..removeUntil(ContainerType.right, (_) => false)
          ..add(
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
    _ShowcaseData(
      title: 'auth',
      subtitle: 'phone: 7-111-111-11-11, code: 11111',
      routeCallback: (BuildContext context) {
        final Widget widget =
            ShowcaseScope.getAuthShowcaseFactory(context).create(context);

        SplitView.of(context)
            // ..removeUntil(ContainerType.top, (_) => false)
            .add(
          key: UniqueKey(),
          builder: (_) => widget,
          container: ContainerType.top,
        );
      },
    ),
    _ShowcaseData(
      title: 'create new channel',
      subtitle: "channel name = 'error' for error",
      routeCallback: (BuildContext context) {
        final Widget widget =
            ShowcaseScope.getCreateNewChannelShowcaseFactory(context)
                .create(context);

        SplitView.of(context).add(
          key: UniqueKey(),
          builder: (_) => widget,
          container: ContainerType.top,
        );
      },
    ),
    _ShowcaseData(
      title: 'new contact',
      routeCallback: (BuildContext context) {
        final Widget widget =
            ShowcaseScope.getNewContactShowcaseFactory(context).create(context);

        SplitView.of(context).add(
          key: UniqueKey(),
          builder: (_) => widget,
          container: ContainerType.top,
        );
      },
    ),
    _ShowcaseData(
      title: 'change username',
      subtitle: 'username = invalid, taken : for errors',
      routeCallback: (BuildContext context) {
        final Widget widget =
            ShowcaseScope.getChangeUsernameShowcaseFactory(context)
                .create(context);

        SplitView.of(context).add(
          key: UniqueKey(),
          builder: (_) => widget,
          container: ContainerType.top,
        );
      },
    ),
    _ShowcaseData(
      title: 'main screen',
      routeCallback: (BuildContext context) {
        final Widget widget =
            ShowcaseScope.getMainScreenShowcaseFactory(context).create(context);

        SplitView.of(context).add(
          key: UniqueKey(),
          builder: (_) => widget,
          container: ContainerType.right,
        );
      },
    ),
    _ShowcaseData(
      title: 'forum screen',
      routeCallback: (BuildContext context) {
        final Widget widget =
            ShowcaseScope.getChatForumScreenShowcaseFactory(context)
                .create(context);

        SplitView.of(context).add(
          key: UniqueKey(),
          builder: (_) => widget,
          container: ContainerType.left,
        );
      },
    ),
    _ShowcaseData(
      title: 'custom emoji',
      routeCallback: (BuildContext context) {
        final Widget widget =
            ShowcaseScope.getCustomEmojiShowcaseFactory(context)
                .create(context);

        SplitView.of(context).add(
          key: UniqueKey(),
          builder: (_) => widget,
          container: ContainerType.right,
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context, rootNavigator: true);

    return Scaffold(
      appBar: AppBar(
        leading: navigator.canPop()
            ? IconButton(
                onPressed: navigator.pop,
                icon: const Icon(Icons.arrow_back),
              )
            : null,
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
            subtitle: showcaseData.subtitle != null
                ? Text(showcaseData.subtitle!)
                : null,
          );
        },
      ),
    );
  }
}

class _ShowcaseData {
  _ShowcaseData({
    required this.title,
    this.subtitle,
    required this.routeCallback,
  });

  final String title;
  final String? subtitle;

  final void Function(BuildContext context) routeCallback;
}
