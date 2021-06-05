import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class StickersFeatureDependencies implements IStickersFeatureDependencies {
  @j.inject
  StickersFeatureDependencies({
    required IConnectionStateProvider connectionStateProvider,
    required IStickerRepository stickerRepository,
    required IStickersFeatureRouter router,
    required ILocalizationManager localizationManager,
  })   : _connectionStateProvider = connectionStateProvider,
        _stickerRepository = stickerRepository,
        _router = router,
        _localizationManager = localizationManager;

  final ILocalizationManager _localizationManager;
  final IConnectionStateProvider _connectionStateProvider;
  final IStickerRepository _stickerRepository;
  final IStickersFeatureRouter _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IConnectionStateProvider get connectionStateProvider =>
      _connectionStateProvider;

  @override
  IStickerRepository get stickerRepository => _stickerRepository;

  @override
  IStickersFeatureRouter get stickersFeatureRouter => _router;
}
