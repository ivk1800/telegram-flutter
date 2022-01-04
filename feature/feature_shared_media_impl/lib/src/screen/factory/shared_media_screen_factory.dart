import 'package:core_arch/core_arch.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:feature_shared_media_impl/feature_shared_media_impl.dart';
import 'package:feature_shared_media_impl/src/di/shared_media_component.dart';
import 'package:feature_shared_media_impl/src/di/shared_media_component.jugger.dart';
import 'package:feature_shared_media_impl/src/screen/factory/shared_media_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_extensions/provider_extensions.dart';

import 'share_media_view_model.dart';

class SharedMediaScreenFactory implements ISharedMediaScreenFactory {
  SharedMediaScreenFactory({
    required SharedMediaFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SharedMediaFeatureDependencies _dependencies;

  @override
  Widget create(SharedContentType type) {
    return Scope<SharedMediaComponent>(
      create: () {
        return JuggerSharedMediaComponentBuilder()
            .dependencies(_dependencies)
            .build();
      },
      providers: (SharedMediaComponent component) {
        return <Provider<dynamic>>[
          ViewModelProvider<SharedMediaViewModel>(
            create: (_) => component.getSharedMediaViewModel(),
          ),
        ];
      },
      child: const SharedMediaPage(),
    );
  }
}
