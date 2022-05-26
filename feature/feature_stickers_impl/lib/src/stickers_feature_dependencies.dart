import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';

import 'stickers_feature_router.dart';

class StickersFeatureDependencies {
  const StickersFeatureDependencies({
    required this.localizationManager,
    required this.connectionStateProvider,
    required this.stickerRepository,
    required this.stickersFeatureRouter,
  });

  final ILocalizationManager localizationManager;

  final IConnectionStateProvider connectionStateProvider;

  final IStickerRepository stickerRepository;

  final IStickersFeatureRouter stickersFeatureRouter;
}
