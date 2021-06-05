import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/feature_stickers_impl.dart';
import 'package:feature_stickers_impl/src/screen/archived_stickers/archived_stickers_page.dart';
import 'package:flutter/widgets.dart';

class ArchivedStickersWidgetFactory implements IArchivedStickersWidgetFactory {
  ArchivedStickersWidgetFactory({required this.dependencies});

  final IStickersFeatureDependencies dependencies;

  @override
  Widget create() => const ArchivedStickersPage();
}
