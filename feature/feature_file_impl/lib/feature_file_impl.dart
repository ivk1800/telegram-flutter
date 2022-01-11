library feature_file_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_file_impl/src/file_downloader.dart';

class FileFeature implements IFileFeatureApi {
  FileFeature({
    required FileFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final FileFeatureDependencies _dependencies;

  late final FileDownloader _fileDownloader = FileDownloader(
    fileUpdatesProvider: _dependencies.fileUpdatesProvider,
    fileRepository: _dependencies.fileRepository,
    functionExecutor: _dependencies.functionExecutor,
  );

  @override
  IFileDownloader get fileDownloader => _fileDownloader;
}

class FileFeatureDependencies {
  FileFeatureDependencies({
    required this.fileUpdatesProvider,
    required this.fileRepository,
    required this.functionExecutor,
  });

  final IFileUpdatesProvider fileUpdatesProvider;
  final IFileRepository fileRepository;
  final ITdFunctionExecutor functionExecutor;
}
