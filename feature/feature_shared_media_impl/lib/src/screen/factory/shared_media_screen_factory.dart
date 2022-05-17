import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:feature_shared_media_impl/feature_shared_media_impl.dart';
import 'package:feature_shared_media_impl/src/di/shared_media_component.jugger.dart';
import 'package:feature_shared_media_impl/src/screen/factory/shared_media_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'shared_media_screen_scope.dart';

class SharedMediaScreenFactory implements ISharedMediaScreenFactory {
  SharedMediaScreenFactory({
    required SharedMediaFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SharedMediaFeatureDependencies _dependencies;

  @override
  Widget create(SharedContentType type) {
    return SharedMediaScreenScope(
      child: const SharedMediaPage(),
      create: () => JuggerSharedMediaComponentBuilder()
          .dependencies(_dependencies)
          .build(),
    );
  }
}
