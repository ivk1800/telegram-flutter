import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'profile_view_model.dart';

class ProfileScreenScope extends StatefulWidget {
  const ProfileScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final IProfileScreenComponent Function() create;

  @override
  State<ProfileScreenScope> createState() => _ProfileScreenScopeState();

  static ProfileViewModel getProfileViewModel(BuildContext context) =>
      _InheritedScope.of(context)._viewModel;

  static IStringsProvider getStringProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static IChatHeaderInfoFactory getChatHeaderInfoFactory(
    BuildContext context,
  ) =>
      _InheritedScope.of(context)._chatHeaderInfoFactory;
}

class _ProfileScreenScopeState extends State<ProfileScreenScope> {
  late final IProfileScreenComponent _component = widget.create.call();

  late final ProfileViewModel _viewModel = _component.getProfileViewModel();

  late final IStringsProvider _stringsProvider =
      _component.getLocalizationManager().stringsProvider;

  late final IChatHeaderInfoFactory _chatHeaderInfoFactory =
      _component.getChatHeaderInfoFactory();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _ProfileScreenScopeState holderState,
  }) : _state = holderState;

  final _ProfileScreenScopeState _state;

  static _ProfileScreenScopeState of(BuildContext context) {
    final _ProfileScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ProfileScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
