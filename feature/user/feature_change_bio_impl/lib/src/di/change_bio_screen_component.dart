import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_change_bio_impl/src/change_bio_feature_dependencies.dmg.dart';
import 'package:feature_change_bio_impl/src/screen/change_bio/change_bio_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

import 'change_bio_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    ChangeBioScreenModule,
    ChangeBioFeatureDependenciesModule,
    TgAppBarModule,
  ],
  builder: IChangeBioScreenComponentBuilder,
)
@j.singleton
abstract class IChangeBioScreenComponent
    implements IChangeBioScreenScopeDelegate {}

@j.module
abstract class ChangeBioScreenModule {}
