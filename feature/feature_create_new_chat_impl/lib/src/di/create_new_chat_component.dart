import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Component(
  modules: <Type>[CreateNewChatModule],
)
abstract class ICreateNewChatComponent {
  ILocalizationManager getLocalizationManager();

  ICreateNewChatRouter getCreateNewChatRouter();
}

@j.module
abstract class CreateNewChatModule {
  @j.provides
  static ILocalizationManager provideLocalizationManager(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      dependencies.localizationManager;

  @j.provides
  static ICreateNewChatRouter provideCreateNewChatRouter(
    CreateNewChatFeatureDependencies dependencies,
  ) =>
      dependencies.router;
}

@j.componentBuilder
abstract class ICreateNewChatComponentBuilder {
  ICreateNewChatComponentBuilder dependencies(
    CreateNewChatFeatureDependencies dependencies,
  );

  ICreateNewChatComponent build();
}
