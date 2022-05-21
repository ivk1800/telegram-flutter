import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_impl/src/di/folders_screen_component.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

import 'folders_view_model.dart';

class FoldersScreenScope extends StatefulWidget {
  const FoldersScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final IFoldersScreenComponent Function() create;

  @override
  State<FoldersScreenScope> createState() => _FoldersScreenScopeState();

  static FoldersViewModel getFoldersViewModel(BuildContext context) =>
      _InheritedScope.of(context)._foldersViewModel;

  static tg.TgAppBarFactory getTgAppBarFactory(BuildContext context) =>
      _InheritedScope.of(context)._tgAppBarFactory;

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;
}

class _FoldersScreenScopeState extends State<FoldersScreenScope> {
  late final IFoldersScreenComponent _component = widget.create.call();

  late final FoldersViewModel _foldersViewModel =
      _component.getFoldersViewModel();

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
    _foldersViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _FoldersScreenScopeState holderState,
  }) : _state = holderState;

  final _FoldersScreenScopeState _state;

  static _FoldersScreenScopeState of(BuildContext context) {
    final _FoldersScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No FoldersScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
