import 'package:feature_chats_list_api/feature_chats_list_api.dart';
import 'package:feature_global_search_api/feature_global_search_api.dart';
import 'package:feature_main_screen_api/feature_main_screen_api.dart';
import 'package:presentation/src/di/component/feature_component.dart';

class FeatureFactory {
  FeatureFactory({required FeatureComponent featureComponent})
      : _featureComponent = featureComponent;

  final FeatureComponent _featureComponent;

  IMainScreenFeatureApi createMainScreenFeature() =>
      _featureComponent.getMainScreenFeatureApi();

  IChatsListFeatureApi createChatsListFeatureApi() =>
      _featureComponent.getChatsListFeatureApi();

  IGlobalSearchFeatureApi createGlobalSearchFeatureApi() =>
      _featureComponent.getGlobalSearchFeatureApi();
}
