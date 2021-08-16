import 'package:app/src/feature/feature.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_wallpappers_impl/feature_wallpappers_impl.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

class WallpappersFeatureDependencies
    implements IWallpappersFeatureDependencies {
  @j.inject
  WallpappersFeatureDependencies({
    required IWallpappersScreenRouter router,
    required FeatureFactory featureFactory,
    required IBackgroundRepository backgroundRepository,
    required IConnectionStateProvider connectionStateProvider,
    required ILocalizationManager localizationManager,
  })  : _router = router,
        _fileDownloader = featureFactory.createFileFeatureApi().fileDownloader,
        _backgroundRepository = backgroundRepository,
        _connectionStateProvider = connectionStateProvider,
        _localizationManager = localizationManager;

  final IWallpappersScreenRouter _router;
  final IBackgroundRepository _backgroundRepository;
  final ILocalizationManager _localizationManager;
  final IConnectionStateProvider _connectionStateProvider;
  final IFileDownloader _fileDownloader;

  @override
  IWallpappersScreenRouter get router => _router;

  @override
  ILocalizationManager get localizationManager => _localizationManager;

  @override
  IConnectionStateProvider get connectionStateProvider =>
      _connectionStateProvider;

  @override
  IBackgroundRepository get backgroundRepository => _backgroundRepository;

  @override
  IFileDownloader get fileDownloader => _fileDownloader;
}
