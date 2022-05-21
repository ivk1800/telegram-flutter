import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_impl/src/di/setup_folder_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'setup_folder_view_model.dart';

class SetupFolderScreenScope extends StatefulWidget {
  const SetupFolderScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final ISetupFolderScreenComponent Function() create;

  @override
  State<SetupFolderScreenScope> createState() => _SetupFolderScreenScopeState();

  static SetupFolderViewModel getSetupFolderViewModel(BuildContext context) =>
      _InheritedScope.of(context)._setupFolderViewModel;

  static tg.TgAppBarFactory getTgAppBarFactory(BuildContext context) =>
      _InheritedScope.of(context)._tgAppBarFactory;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _SetupFolderScreenScopeState extends State<SetupFolderScreenScope> {
  late final ISetupFolderScreenComponent _component = widget.create.call();

  late final SetupFolderViewModel _setupFolderViewModel =
      _component.getSetupFolderViewModel();

  late final tg.TgAppBarFactory _tgAppBarFactory =
      _component.getTgAppBarFactory();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(
      holderState: this,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _setupFolderViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _SetupFolderScreenScopeState holderState,
  }) : _state = holderState;

  final _SetupFolderScreenScopeState _state;

  static _SetupFolderScreenScopeState of(BuildContext context) {
    final _SetupFolderScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No SetupFolderScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
