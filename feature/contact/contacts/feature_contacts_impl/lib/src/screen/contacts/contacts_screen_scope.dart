import 'package:feature_contacts_impl/src/di/di.dart';
import 'package:feature_contacts_impl/src/screen/contacts/contacts_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider_extensions/provider_extensions.dart';

class ContactsScreenScope extends StatefulWidget {
  const ContactsScreenScope({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;
  final CreateComponent<IContactsScreenComponent> create;

  @override
  State<ContactsScreenScope> createState() => _ContactsScreenScopeState();

  static IStringsProvider getStringsProvider(BuildContext context) =>
      _InheritedScope.of(context)._stringsProvider;

  static ContactsViewModel getContactsViewModel(BuildContext context) =>
      _InheritedScope.of(context)._contactsViewModel;
}

class _ContactsScreenScopeState extends State<ContactsScreenScope> {
  late final IContactsScreenComponent _component = widget.create.call();

  late final IStringsProvider _stringsProvider =
      _component.getStringsProvider();
  late final ContactsViewModel _contactsViewModel =
      _component.getContactsViewModel();

  @override
  Widget build(BuildContext context) {
    return _InheritedScope(state: this, child: widget.child);
  }

  @override
  void dispose() {
    _contactsViewModel.dispose();
    super.dispose();
  }
}

class _InheritedScope extends InheritedWidget {
  const _InheritedScope({
    required super.child,
    required _ContactsScreenScopeState state,
  }) : _state = state;

  final _ContactsScreenScopeState _state;

  static _ContactsScreenScopeState of(BuildContext context) {
    final _ContactsScreenScopeState? result = (context
            .getElementForInheritedWidgetOfExactType<_InheritedScope>()
            ?.widget as _InheritedScope?)
        ?._state;
    assert(result != null, 'No ContactsScreenScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_InheritedScope oldWidget) => false;
}
