import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_chat_forum_impl/src/screen/body_state.dart';
import 'package:feature_chat_forum_impl/src/screen/chat_forum_screen_scope_delegate.scope.dart';
import 'package:feature_chat_forum_impl/src/screen/chat_forum_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

class ChatForumPage extends StatelessWidget {
  const ChatForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('forum'),
      ),
      body: const _Body(),
      floatingActionButton: const _FloatingNewTopicButton(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final ChatForumViewModel viewModel =
        ChatForumScreenScope.getChatForumViewModel(context);

    return StreamListener<BodyState>(
      stream: viewModel.state,
      builder: (BuildContext context, BodyState state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: state.map(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            empty: (_) => const _EmptyState(),
            content: (ChatForumContentState value) {
              return _Content(models: value.topics);
            },
          ),
        );
      },
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.models});

  final List<ITileModel> models;

  @override
  Widget build(BuildContext context) {
    final TileFactory tileFactory =
        ChatForumScreenScope.getTopicsTileFactory(context);

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 90),
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 0);
      },
      itemCount: models.length,
      itemBuilder: (BuildContext context, int index) {
        return tileFactory.create(context, models[index]);
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        ChatForumScreenScope.getStringsProvider(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // TODO: display sticker
          const FlutterLogo(size: 100),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              stringsProvider.noTopics,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              stringsProvider.noTopicsDescription(<Object>['?']),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingNewTopicButton extends StatelessWidget {
  const _FloatingNewTopicButton();

  @override
  Widget build(BuildContext context) {
    final ChatForumViewModel viewModel =
        ChatForumScreenScope.getChatForumViewModel(context);

    return StreamListener<BodyState>(
      stream: viewModel.state,
      builder: (BuildContext context, BodyState state) {
        final bool showHint = state.maybeWhen(
          empty: () => true,
          orElse: () => false,
        );
        final IStringsProvider stringsProvider =
            ChatForumScreenScope.getStringsProvider(context);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (showHint) ...<Widget>[
              Flexible(
                child: Text(
                  '${stringsProvider.tapToCreateTopicHint} >',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 16.0),
            ],
            FloatingActionButton(
              child: const Icon(Icons.message),
              onPressed: viewModel.onCreateTopicTap,
            )
          ],
        );
      },
    );
  }
}
