import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:chat_theme/chat_theme.dart';
import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/src/widget/chat_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tg_theme/tg_theme.dart';
import 'package:tile/tile.dart';

import 'view_model/chat_view_model.dart';
import 'chat_state.dart';
import 'view_model/chat_actions_panel_view_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final ScrollController _messagesScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _messagesScrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _messagesScrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatViewModel viewModel = context.read();
    final ChatActionsPanelViewModel chatActionsViewModel = context.read();
    return Scaffold(
      backgroundColor:
          TgTheme.of(context).themeOf<ChatThemeData>().backgroundColor,
      appBar: const _AppBar(),
      body: StreamListener<BodyState>(
        stream: viewModel.bodyStateStream,
        builder: (BuildContext context, BodyState data) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: data.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (List<ITileModel> models) {
                return _ChatContextWrapper(
                  child: _Messages(
                    scrollController: _messagesScrollController,
                    models: models,
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: StreamListener<PanelState>(
          stream: chatActionsViewModel.actionsPanelState,
          builder: (BuildContext context, PanelState state) {
            final IChatActionPanelFactory factory = context.read();
            return factory.create(state);
          },
        ),
      ),
    );
  }

  void _onScroll() {
    final double extentAfter = _messagesScrollController.position.extentAfter;
    if (extentAfter < 200) {
      context.read<ChatViewModel>().onLoadMore();
    }
  }
}

class _ChatContextWrapper extends StatelessWidget {
  const _ChatContextWrapper({Key? key, required this.child}) : super(key: key);

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

class _Messages extends StatelessWidget {
  const _Messages({
    Key? key,
    required this.scrollController,
    required this.models,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<ITileModel> models;

  @override
  Widget build(BuildContext context) {
    final TileFactory tileFactory = context.read();
    return Scrollbar(
      child: ListView.separated(
        // todo extract to config
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        controller: scrollController,
        reverse: true,
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) {
          final ITileModel tileModel = models[index];
          return tileFactory.create(context, tileModel);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8.0);
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatViewModel viewModel = context.read();
    return StreamListener<HeaderState>(
      stream: viewModel.headerStateStream,
      builder: (BuildContext context, HeaderState data) {
        final IChatHeaderInfoFactory chatHeaderInfoFactory = context.read();
        return AppBar(
          titleSpacing: 0.0,
          // todo wrap to builder?
          title: chatHeaderInfoFactory.create(
            context: context,
            info: data.info,
          ),
          actions: <Widget>[
            _AppBarPopupMenu(
              actions: data.actions,
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
    Key? key,
    required this.onSelected,
    required this.actions,
  }) : super(key: key);

  final List<HeaderActionData> actions;
  final PopupMenuItemSelected<HeaderAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<HeaderAction>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => actions
          .map((HeaderActionData e) => PopupMenuItem<HeaderAction>(
                value: e.action,
                child: AppBarPopupMenuItem(
                  title: e.label,
                ),
              ))
          .toList(),
    );
  }
}

// todo same in settings page, extract common widget
class AppBarPopupMenuItem extends StatelessWidget {
  const AppBarPopupMenuItem({Key? key, required this.title}) : super(key: key);

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
