import 'dart:io';
import 'dart:typed_data';

import 'package:coreui/coreui.dart';
import 'package:fake/fake.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:showcase/src/showcase/avatar/avatar_showcase_component.dart';
import 'package:showcase/src/showcase/avatar/avatar_showcase_page.dart';
import 'package:showcase/src/showcase/avatar/avatar_showcase_scope.dart';

import 'avatar_showcase_repository.dart';

class AvatarShowcaseFactory {
  @j.inject
  const AvatarShowcaseFactory();

  Widget create(BuildContext context) {
    final IFileDownloader _fileDownloader = FakeFileDownloader(
      fileDownloadStateStreamProvider: (int fileId) {
        if (fileId == AvatarsRepository.sLoadWithMinithumbnail) {
          return Stream<FileDownloadState>.value(
            const FileDownloadState.downloading(
              progress: 0,
            ),
          ).delay(const Duration(seconds: 1)).asyncMap((_) async {
            final ByteData durov = await rootBundle.load(
              'packages/showcase/assets/durov.jpg',
            );

            final File durovAvatarFile = File(
              '${Directory.systemTemp.path}/temp_durov',
            );
            await durovAvatarFile.writeAsBytes(
              durov.buffer.asUint8List(
                durov.offsetInBytes,
                durov.lengthInBytes,
              ),
            );

            return FileDownloadState.completed(path: durovAvatarFile.path);
          });
        }

        return null;
      },
    );

    return AvatarShowcaseScope(
      child: const AvatarShowcasePage(),
      create: () {
        return AvatarShowcaseComponent(
          avatarsRepository: AvatarsRepository(),
          avatarWidgetFactory: AvatarWidgetFactory(
            fileDownloader: _fileDownloader,
          ),
        );
      },
    );
  }
}
