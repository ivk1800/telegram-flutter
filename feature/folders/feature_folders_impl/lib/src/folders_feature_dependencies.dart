import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:localization_api/localization_api.dart';

import 'folders_router.dart';

class FoldersFeatureDependencies {
  const FoldersFeatureDependencies({
    required this.router,
    required this.connectionStateProvider,
    required this.stringsProvider,
  });

  final IFoldersRouter router;

  final IConnectionStateProvider connectionStateProvider;

  final IStringsProvider stringsProvider;
}
