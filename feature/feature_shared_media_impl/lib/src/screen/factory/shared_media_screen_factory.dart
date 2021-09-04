import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:feature_shared_media_impl/feature_shared_media_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SharedMediaScreenFactory implements ISharedMediaScreenFactory {
  SharedMediaScreenFactory({
    required SharedMediaFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final SharedMediaFeatureDependencies _dependencies;

  @override
  Widget create(BuildContext context, SharedContentType type) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedMediaScreen'),
      ),
    );
  }
}
