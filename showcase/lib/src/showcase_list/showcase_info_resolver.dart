import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/showcase/auth_showcase_factory.dart';
import 'package:showcase/src/showcase/avatar/avatar_showcase_factory.dart';
import 'package:showcase/src/showcase/change_username_showcase_factory.dart';
import 'package:showcase/src/showcase/chat_cell/chat_cell_showcase.dart';
import 'package:showcase/src/showcase/chat_forum_screen_showcase_factory.dart';
import 'package:showcase/src/showcase/circular_progress/circular_progress_widget_showcase_factory.dart';
import 'package:showcase/src/showcase/create_new_channel_showcase_factory.dart';
import 'package:showcase/src/showcase/custom_emoji/custom_emoji_showcase_factory.dart';
import 'package:showcase/src/showcase/image_widget/image_widget_showcase_factory.dart';
import 'package:showcase/src/showcase/main_screen_showcase_factory.dart';
import 'package:showcase/src/showcase/message_wrap/message_wrap_showcase_factory.dart';
import 'package:showcase/src/showcase/new_contact_showcase_factory.dart';
import 'package:showcase/src/showcase_messages_list_page.dart';
import 'package:showcase/src/showcase_split_view_page.dart';
import 'package:split_view/split_view.dart';
import 'package:tile/tile.dart';

import 'showcase_list_screen_factory.dart';
import 'showcase_params.dart';
import 'tile/model/group_tile_model.dart';
import 'tile/model/showcase_tile_model.dart';

class ShowcaseInfoResolver {
  @j.inject
  const ShowcaseInfoResolver({
    required AuthShowcaseFactory authShowcaseFactory,
    required ShowcaseListScreenFactory showcaseListScreenFactory,
    required CreateNewChannelShowcaseFactory createNewChannelShowcaseFactory,
    required NewContactShowcaseFactory newContactShowcaseFactory,
    required ChangeUsernameShowcaseFactory changeUsernameShowcaseFactory,
    required MainScreenShowcaseFactory mainScreenShowcaseFactory,
    required ChatForumScreenShowcaseFactory chatForumScreenShowcaseFactory,
    required ImageWidgetShowcaseFactory imageWidgetShowcaseFactory,
    required CircularProgressWidgetShowcaseFactory
        circularProgressWidgetShowcaseFactory,
    required MessageWrapShowcaseFactory messageWrapShowcaseFactory,
    required CustomEmojiShowcaseFactory customEmojiShowcaseFactory,
    required AvatarShowcaseFactory avatarShowcaseFactory,
  })  : _authShowcaseFactory = authShowcaseFactory,
        _createNewChannelShowcaseFactory = createNewChannelShowcaseFactory,
        _newContactShowcaseFactory = newContactShowcaseFactory,
        _changeUsernameShowcaseFactory = changeUsernameShowcaseFactory,
        _mainScreenShowcaseFactory = mainScreenShowcaseFactory,
        _chatForumScreenShowcaseFactory = chatForumScreenShowcaseFactory,
        _imageWidgetShowcaseFactory = imageWidgetShowcaseFactory,
        _circularProgressWidgetShowcaseFactory =
            circularProgressWidgetShowcaseFactory,
        _messageWrapShowcaseFactory = messageWrapShowcaseFactory,
        _customEmojiShowcaseFactory = customEmojiShowcaseFactory,
        _avatarShowcaseFactory = avatarShowcaseFactory,
        _showcaseListScreenFactory = showcaseListScreenFactory;

  final AuthShowcaseFactory _authShowcaseFactory;
  final ShowcaseListScreenFactory _showcaseListScreenFactory;
  final CreateNewChannelShowcaseFactory _createNewChannelShowcaseFactory;
  final NewContactShowcaseFactory _newContactShowcaseFactory;
  final ChangeUsernameShowcaseFactory _changeUsernameShowcaseFactory;
  final MainScreenShowcaseFactory _mainScreenShowcaseFactory;
  final ChatForumScreenShowcaseFactory _chatForumScreenShowcaseFactory;
  final ImageWidgetShowcaseFactory _imageWidgetShowcaseFactory;
  final CircularProgressWidgetShowcaseFactory
      _circularProgressWidgetShowcaseFactory;
  final MessageWrapShowcaseFactory _messageWrapShowcaseFactory;
  final CustomEmojiShowcaseFactory _customEmojiShowcaseFactory;
  final AvatarShowcaseFactory _avatarShowcaseFactory;

  ShowcaseInfo resolve({
    required BuildContext context,
    required ShowcaseParams params,
  }) {
    return params.map(
      initialScreen: (_) {
        return ShowcaseInfo(
          widget: _showcaseListScreenFactory.create(
            title: 'Showcase',
            items: <ITileModel>[
              const GroupTileModel(
                title: 'Screen',
                items: <ITileModel>[
                  ShowcaseTileModel(
                    title: 'Auth',
                    description: 'phone: 7-111-111-11-11, code: 11111',
                    params: ShowcaseParams.authScreen(),
                  ),
                  ShowcaseTileModel(
                    title: 'Create new channel',
                    description: "channel name = 'error' for error",
                    params: ShowcaseParams.createNewChannelScreen(),
                  ),
                  ShowcaseTileModel(
                    title: 'New contact',
                    params: ShowcaseParams.newContactScreen(),
                  ),
                  ShowcaseTileModel(
                    title: 'Change username',
                    description: 'username = invalid, taken : for errors',
                    params: ShowcaseParams.changeUsernameScreen(),
                  ),
                  ShowcaseTileModel(
                    title: 'Main',
                    params: ShowcaseParams.mainScreen(),
                  ),
                  ShowcaseTileModel(
                    title: 'Forum',
                    params: ShowcaseParams.forumScreen(),
                  ),
                ],
              ),
              const GroupTileModel(
                title: 'Widget',
                items: <ITileModel>[
                  ShowcaseTileModel(
                    title: 'Chat cells',
                    params: ShowcaseParams.chatCells(),
                  ),
                  ShowcaseTileModel(
                    title: 'Chat messages',
                    params: ShowcaseParams.chatMessages(),
                  ),
                  ShowcaseTileModel(
                    title: 'Custom emoji',
                    params: ShowcaseParams.customEmojiWidget(),
                  ),
                  ShowcaseTileModel(
                    title: 'Message wrap',
                    params: ShowcaseParams.messageWrapWidget(),
                  ),
                  ShowcaseTileModel(
                    title: 'Circular progress',
                    params: ShowcaseParams.circularProgressWidget(),
                  ),
                  ShowcaseTileModel(
                    title: 'Image',
                    params: ShowcaseParams.imageWidget(),
                  ),
                  ShowcaseTileModel(
                    title: 'Avatar',
                    params: ShowcaseParams.avatarWidget(),
                  ),
                ],
              ),
              const ShowcaseTileModel(
                title: 'Split view',
                params: ShowcaseParams.splitView(),
              ),
            ],
          ),
          containerType: ContainerType.left,
        );
      },
      authScreen: (_) {
        //+
        return ShowcaseInfo(
          widget: _authShowcaseFactory.create(context),
          containerType: ContainerType.top,
        );
      },
      createNewChannelScreen: (_) {
        return ShowcaseInfo(
          widget: _createNewChannelShowcaseFactory.create(context),
          containerType: ContainerType.top,
        );
      },
      newContactScreen: (_) {
        return ShowcaseInfo(
          widget: _newContactShowcaseFactory.create(context),
          containerType: ContainerType.top,
        );
      },
      changeUsernameScreen: (_) {
        return ShowcaseInfo(
          widget: _changeUsernameShowcaseFactory.create(context),
          containerType: ContainerType.top,
        );
      },
      mainScreen: (_) {
        return ShowcaseInfo(
          widget: _mainScreenShowcaseFactory.create(context),
          containerType: ContainerType.right,
        );
      },
      forumScreen: (_) {
        return ShowcaseInfo(
          widget: _chatForumScreenShowcaseFactory.create(context),
          containerType: ContainerType.left,
        );
      },
      splitView: (_) {
        return const ShowcaseInfo(
          widget: ShowcaseSplitViewPage(),
          containerType: ContainerType.top,
        );
      },
      imageWidget: (_) {
        return ShowcaseInfo(
          widget: _imageWidgetShowcaseFactory.create(context),
          containerType: ContainerType.right,
        );
      },
      circularProgressWidget: (_) {
        return ShowcaseInfo(
          widget: _circularProgressWidgetShowcaseFactory.create(context),
          containerType: ContainerType.right,
        );
      },
      messageWrapWidget: (_) {
        return ShowcaseInfo(
          widget: _messageWrapShowcaseFactory.create(context),
          containerType: ContainerType.right,
        );
      },
      customEmojiWidget: (_) {
        return ShowcaseInfo(
          widget: _customEmojiShowcaseFactory.create(context),
          containerType: ContainerType.right,
        );
      },
      chatMessages: (_) {
        return const ShowcaseInfo(
          widget: ShowcaseMessageListPage(),
          containerType: ContainerType.left,
        );
      },
      chatCells: (_) {
        return const ShowcaseInfo(
          widget: ChatCellShowCase(),
          containerType: ContainerType.right,
        );
      },
      avatarWidget: (AvatarWidget value) {
        return ShowcaseInfo(
          widget: _avatarShowcaseFactory.create(context),
          containerType: ContainerType.right,
        );
      },
    );
  }
}

@immutable
class ShowcaseInfo {
  const ShowcaseInfo({
    required this.widget,
    required this.containerType,
  });

  final Widget widget;
  final ContainerType containerType;
}
