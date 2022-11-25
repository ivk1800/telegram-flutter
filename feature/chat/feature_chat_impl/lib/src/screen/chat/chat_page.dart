import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:feature_chat_impl/src/widget/chat_context.dart';
import 'package:flutter/material.dart';

import 'messages_bundle.dart';
import 'messages_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ChatScreenScope.getChatBackgroundFactory(context).create(context),
        _ChatContextWrapper(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const _AppBar(),
            body: Column(
              children: const <Widget>[
                Expanded(child: _Body()),
                _ActionsPanel(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final ChatMessagesViewModel viewModel =
        ChatScreenScope.getChatMessagesViewModel(context);

    return StreamListener<BodyState>(
      stream: viewModel.bodyStateStream,
      builder: (BuildContext context, BodyState data) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: data.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (IMessagesBundle messagesBundle) {
              return MessagesList(messagesBundle: messagesBundle);
            },
            empty: () {
              return ChatScreenScope.getEmptyChatWidgetFactory(context)
                  .create();
            },
          ),
        );
      },
    );
  }
}

class _ActionsPanel extends StatelessWidget {
  const _ActionsPanel();

  @override
  Widget build(BuildContext context) {
    return ChatScreenScope.getChatActionPanelFactory(context).create();
  }
}

// todo may be move to chat screen scope?
class _ChatContextWrapper extends StatelessWidget {
  const _ChatContextWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ChatContext(
          data: ChatContextData.desktop(maxWidth: constraints.maxWidth),
          child: child,
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final ChatActionBarViewModel viewModel =
        ChatScreenScope.getChatActionBarModel(context);
    return StreamBuilder<HeaderState>(
      stream: viewModel.headerStateStream,
      builder: (BuildContext context, AsyncSnapshot<HeaderState> data) {
        final HeaderState? state = data.data;

        // TODO: temporary, fix stuck
        if (state == null) {
          return AppBar();
        }

        final IChatHeaderInfoFactory chatHeaderInfoFactory =
            ChatScreenScope.getChatHeaderInfoFactory(context);
        return AppBar(
          titleSpacing: 0.0,
          // todo wrap to builder?
          title: chatHeaderInfoFactory.create(
            context: context,
            info: state.info,
            onProfileTap: viewModel.onOpenSelfProfileTap,
          ),
          actions: <Widget>[
            _AppBarPopupMenu(
              actions: state.actions,
              onSelected: viewModel.onHeaderActionTap,
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _AppBarPopupMenu extends StatelessWidget {
  const _AppBarPopupMenu({
    required this.onSelected,
    required this.actions,
  });

  final List<HeaderActionData> actions;
  final PopupMenuItemSelected<HeaderAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<HeaderAction>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => actions
          .map(
            (HeaderActionData e) => PopupMenuItem<HeaderAction>(
              value: e.action,
              child: AppBarPopupMenuItem(
                title: e.label,
              ),
            ),
          )
          .toList(),
    );
  }
}

// todo same in settings page, extract common widget
class AppBarPopupMenuItem extends StatelessWidget {
  const AppBarPopupMenuItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.circle),
      title: Text(title),
    );
  }
}
