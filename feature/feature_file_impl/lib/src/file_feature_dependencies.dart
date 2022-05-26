library feature_file_impl;

import 'package:core_tdlib_api/core_tdlib_api.dart';

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
