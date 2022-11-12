import 'package:coreui/coreui.dart';
import 'package:fake/fake.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;

import 'image_widget_showcase_page.dart';
import 'image_widget_showcase_scope_delegate.dart';
import 'image_widget_showcase_scope_delegate.scope.dart';

class ImageWidgetShowcaseFactory {
  @j.inject
  ImageWidgetShowcaseFactory();

  Widget create(BuildContext context) {
    return ImageWidgetShowcaseScope(
      create: _Delegate.new,
      child: const ImageWidgetShowcasePage(),
    );
  }
}

class _Delegate implements IImageWidgetShowcaseScopeDelegate {
  final FakeFileDownloader _fileDownloader = FakeFileDownloader(
    fileDownloadStateStreamProvider: (int fileId) {
      return () async* {
        yield const FileDownloadState.downloading(progress: 10);
        await Future<void>.delayed(const Duration(milliseconds: 200));
        yield const FileDownloadState.downloading(progress: 50);
        await Future<void>.delayed(const Duration(milliseconds: 300));
        yield const FileDownloadState.downloading(progress: 90);
        await Future<void>.delayed(const Duration(milliseconds: 400));
        yield FileDownloadState.completed(
          path: (await readFileFromAssets(
            key: 'packages/fake/assets/file/sticker/thumbnail/file_1361.jpeg',
            fileName: 'file_1361.jpeg',
          ))
              .path,
        );
      }();
    },
  );

  late final ImageWidgetFactory _factory = ImageWidgetFactory(
    fileDownloader: _fileDownloader,
  );

  @override
  ImageWidgetFactory getImageWidgetFactory() {
    return _factory;
  }
}
