import 'package:flutter/widgets.dart';
import 'package:showcase/src/di/showcase_component.dart';
import 'package:showcase/src/showcase/auth_showcase_factory.dart';
import 'package:showcase/src/showcase/custom_emoji/custom_emoji_showcase_factory.dart';
import 'package:showcase/src/showcase/main_screen_showcase_factory.dart';

import 'avatar/avatar_showcase_factory.dart';
import 'change_username_showcase_factory.dart';
import 'chat_forum_screen_showcase_factory.dart';
import 'create_new_channel_showcase_factory.dart';
import 'message/message_showcase_factory.dart';
import 'message_wrap/message_wrap_showcase_factory.dart';
import 'new_contact_showcase_factory.dart';
import 'widget/showcase_block_interaction_manager.dart';

class ShowcaseScope extends StatefulWidget {
  const ShowcaseScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final IShowcaseComponent Function() create;

  @override
  State<ShowcaseScope> createState() => _ShowcaseScopeState();

  static ChangeUsernameShowcaseFactory getChangeUsernameShowcaseFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._changeUsernameShowcaseFactory;

  static NewContactShowcaseFactory getNewContactShowcaseFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._newContactShowcaseFactory;

  static CreateNewChannelShowcaseFactory getCreateNewChannelShowcaseFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._createNewChannelShowcaseFactory;

  static AuthShowcaseFactory getAuthShowcaseFactory(BuildContext context) =>
      _InheritedScope.of(context)._authShowcaseFactory;

  static ShowcaseBlockInteractionManager getShowcaseBlockInteractionManager(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._showcaseBlockInteractionManager;

  static MessageShowcaseFactory getMessageShowcaseFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._messageShowcaseFactory;

  static MainScreenShowcaseFactory getMainScreenShowcaseFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._mainScreenShowcaseFactory;

  static AvatarShowcaseFactory getAvatarShowcaseFactory(BuildContext context) =>
      _InheritedScope.of(context)._avatarShowcaseFactory;

  static ChatForumScreenShowcaseFactory getChatForumScreenShowcaseFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._chatForumScreenShowcaseFactory;

  static CustomEmojiShowcaseFactory getCustomEmojiShowcaseFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._customEmojiShowcaseFactory;

  static MessageWrapShowcaseFactory getMessageWrapShowcaseFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._messageWrapShowcaseFactory;
}

class _ShowcaseScopeState extends State<ShowcaseScope> {
  late final IShowcaseComponent _component = widget.create.call();

  late final ChangeUsernameShowcaseFactory _changeUsernameShowcaseFactory =
      _component.getChangeUsernameShowcaseFactory();

  late final NewContactShowcaseFactory _newContactShowcaseFactory =
      _component.getNewContactShowcaseFactory();

  late final CreateNewChannelShowcaseFactory _createNewChannelShowcaseFactory =
      _component.getCreateNewChannelShowcaseFactory();

  late final AuthShowcaseFactory _authShowcaseFactory =
      _component.getAuthShowcaseFactory();

  late final AvatarShowcaseFactory _avatarShowcaseFactory =
      _component.getAvatarShowcaseFactory();

  late final ShowcaseBlockInteractionManager _showcaseBlockInteractionManager =
      _component.getShowcaseBlockInteractionManager();

  late final MessageShowcaseFactory _messageShowcaseFactory =
      _component.getMessageShowcaseFactory();

  late final MainScreenShowcaseFactory _mainScreenShowcaseFactory =
      _component.getMainScreenShowcaseFactory();

  late final ChatForumScreenShowcaseFactory _chatForumScreenShowcaseFactory =
      _component.getChatForumScreenShowcaseFactory();

  late final CustomEmojiShowcaseFactory _customEmojiShowcaseFactory =
      _component.getCustomEmojiShowcaseFactory();

  late final MessageWrapShowcaseFactory _messageWrapShowcaseFactory =
      _component.getMessageWrapShowcaseFactory();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _ShowcaseScopeState holderState,
  }) : _state = holderState;

  final _ShowcaseScopeState _state;

  static _ShowcaseScopeState of(BuildContext context) {
    final _ShowcaseScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ShowcaseScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
