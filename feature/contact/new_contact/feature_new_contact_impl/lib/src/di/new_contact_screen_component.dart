import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_ui_jugger/core_ui_jugger.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_new_contact_impl/src/new_contact_feature_dependencies.dmg.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_screen_scope_delegate.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:user_info/user_info.dart';

import 'new_contact_screen_component_builder.dart';

@j.Component(
  modules: <Type>[
    NewContactScreenModule,
    NewContactFeatureDependenciesModule,
    TgAppBarModule,
  ],
  builder: INewContactScreenComponentBuilder,
)
abstract class INewContactScreenComponent
    implements INewContactScreenScopeDelegate {}

@j.module
abstract class NewContactScreenModule {
  @j.provides
  @j.singleton
  static AvatarWidgetFactory provideAvatarWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      AvatarWidgetFactory(fileDownloader: fileDownloader);

  @j.provides
  @j.singleton
  static UserInfoResolver provideUserInfoResolver(
    IUserRepository userRepository,
  ) =>
      UserInfoResolver(userRepository: userRepository);
}
