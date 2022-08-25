import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_file_impl/src/file_downloader.dart';

import 'file_feature_dependencies.dart';

class FileFeature implements IFileFeatureApi {
  FileFeature({
    required FileFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final FileFeatureDependencies _dependencies;

  @override
  late final IFileDownloader fileDownloader = FileDownloader(
    fileUpdatesProvider: _dependencies.fileUpdatesProvider,
    fileRepository: _dependencies.fileRepository,
    functionExecutor: _dependencies.functionExecutor,
  );
}
