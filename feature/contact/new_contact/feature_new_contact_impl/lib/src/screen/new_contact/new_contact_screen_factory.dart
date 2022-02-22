import 'package:feature_new_contact_api/feature_new_contact_api.dart';
import 'package:feature_new_contact_impl/feature_new_contact_impl.dart';
import 'package:feature_new_contact_impl/src/di/new_contact_screen_component.jugger.dart';
import 'package:flutter/material.dart';

import 'new_contact_page.dart';
import 'new_contact_screen_scope.dart';

class NewContactScreenFactory implements INewContactScreenFactory {
  NewContactScreenFactory({required NewContactFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final NewContactFeatureDependencies _dependencies;

  @override
  Widget create() {
    return NewContactScreenScope(
      child: const NewContactPage(),
      create: () => JuggerNewContactScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
