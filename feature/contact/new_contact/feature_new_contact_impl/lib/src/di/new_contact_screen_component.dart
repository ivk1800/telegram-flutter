import 'package:coreui/coreui.dart';
import 'package:feature_new_contact_impl/feature_new_contact_impl.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/args.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_controller.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_view_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:user_info/user_info.dart';

@j.Component(
  modules: <Type>[NewContactScreenModule],
)
abstract class INewContactScreenComponent {
  IStringsProvider getStringsProvider();

  NewContactViewModel getNewContactViewModel();

  NewContactController getNewContactController();

  AvatarWidgetFactory getAvatarWidgetFactory();
}

@j.module
abstract class NewContactScreenModule {
  @j.provides
  @j.singleton
  static IStringsProvider provideStringsProvider(
    NewContactFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.provides
  @j.singleton
  static AvatarWidgetFactory provideAvatarWidgetFactory(
    NewContactFeatureDependencies dependencies,
  ) =>
      AvatarWidgetFactory(fileRepository: dependencies.fileRepository);

  @j.provides
  @j.singleton
  static UserInfoResolver provideUserInfoResolver(
    NewContactFeatureDependencies dependencies,
  ) =>
      UserInfoResolver(userRepository: dependencies.userRepository);

  @j.provides
  @j.singleton
  static NewContactViewModel provideNewContactViewModel(
    Args args,
    NewContactFeatureDependencies dependencies,
    UserInfoResolver userInfoResolver,
  ) =>
      NewContactViewModel(
        errorTransformer: dependencies.errorTransformer,
        contactsManager: dependencies.contactsManager,
        router: dependencies.router,
        args: args,
        stringsProvider: dependencies.stringsProvider,
        blockInteractionManager: dependencies.blockInteractionManager,
        userInfoResolver: userInfoResolver,
      )..init();
}

@j.componentBuilder
abstract class INewContactScreenComponentBuilder {
  INewContactScreenComponentBuilder dependencies(
    NewContactFeatureDependencies dependencies,
  );

  INewContactScreenComponentBuilder args(Args args);

  INewContactScreenComponent build();
}
