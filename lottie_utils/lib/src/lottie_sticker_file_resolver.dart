import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LottieStickerFileResolver {
  const LottieStickerFileResolver();

  // todo add cache, optimize
  Future<File> resolve(String tgsFilePath) async {
    final InputFileStream inputStream = InputFileStream(tgsFilePath);
    final List<int> archive = GZipDecoder().decodeBuffer(inputStream);
    final Directory directory =
        Directory('${(await getTemporaryDirectory()).path}/stickers_lottie');

    // todo refactor
    // ignore: avoid_slow_async_io
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }

    final File lottieFile = File(
      '${directory.path}/${basename(tgsFilePath)}',
    );
    // todo refactor
    // ignore: avoid_slow_async_io
    if (!(await lottieFile.exists())) {
      await lottieFile.writeAsBytes(archive);
    }
    return lottieFile;
  }
}
