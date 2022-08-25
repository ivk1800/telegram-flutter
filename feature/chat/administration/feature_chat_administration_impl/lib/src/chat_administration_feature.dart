import 'package:feature_chat_administration_api/feature_chat_administration_api.dart';

import 'chat_administration_feature_dependencies.dart';
import 'screen/chat_administration/chat_administration_screen_factory.dart';

class ChatAdministrationFeature implements IChatAdministrationFeatureApi {
  ChatAdministrationFeature({
    required ChatAdministrationFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final ChatAdministrationFeatureDependencies _dependencies;

  @override
  late final IChatAdministrationScreenFactory chatAdministrationScreenFactory =
      ChatAdministrationScreenFactory(dependencies: _dependencies);
}
