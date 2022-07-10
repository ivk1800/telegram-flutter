import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:feature_change_bio_impl/feature_change_bio_impl.dart';
import 'package:feature_change_bio_impl/src/change_bio_feature_dependencies.dmg.dart';
import 'package:feature_change_bio_impl/src/screen/change_bio/change_bio_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;

@j.Component(
  modules: <Type>[
    ChangeBioScreenModule,
    ChangeBioFeatureDependenciesModule,
    TgAppBarModule,
  ],
)
abstract class IChangeBioScreenComponent
    implements IChangeBioScreenScopeDelegate {}

@j.module
abstract class ChangeBioScreenModule {}

@j.componentBuilder
abstract class IChangeBioScreenComponentBuilder {
  IChangeBioScreenComponentBuilder dependencies(
    ChangeBioFeatureDependencies dependencies,
  );

  IChangeBioScreenComponent build();
}
