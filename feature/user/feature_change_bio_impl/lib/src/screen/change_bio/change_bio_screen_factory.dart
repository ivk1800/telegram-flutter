import 'package:feature_change_bio_api/feature_change_bio_api.dart';
import 'package:feature_change_bio_impl/feature_change_bio_impl.dart';
import 'package:feature_change_bio_impl/src/di/change_bio_screen_component.jugger.dart';
import 'package:feature_change_bio_impl/src/screen/change_bio/change_bio_screen_scope.dart';
import 'package:flutter/material.dart';

import 'change_bio_page.dart';

class ChangeBioScreenFactory implements IChangeBioScreenFactory {
  ChangeBioScreenFactory({
    required ChangeBioFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChangeBioFeatureDependencies _dependencies;

  @override
  Widget create() {
    return ChangeBioScreenScope(
      child: const ChangeBioPage(),
      create: () => JuggerChangeBioScreenComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
