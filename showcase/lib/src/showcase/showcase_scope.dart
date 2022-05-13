import 'package:flutter/widgets.dart';
import 'package:provider_extensions/provider_extensions.dart';
import 'package:showcase/src/di/showcase_component.dart';
import 'package:showcase/src/showcase/auth_showcase_factory.dart';

import 'change_username_showcase_factory.dart';
import 'create_new_channel_showcase_factory.dart';
import 'new_contact_showcase_factory.dart';
import 'widget/showcase_block_interaction_manager.dart';

class ShowcaseScope extends StatefulWidget {
  const ShowcaseScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IShowcaseComponent> create;

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

  late final ShowcaseBlockInteractionManager _showcaseBlockInteractionManager =
      _component.getShowcaseBlockInteractionManager();

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
