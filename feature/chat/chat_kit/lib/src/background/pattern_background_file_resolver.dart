import 'dart:io';
import 'dart:ui' as ui;

import 'package:archive/archive_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

class PatternBackgroundFileResolver {
  const PatternBackgroundFileResolver();

  Future<File> resolve({
    required int backgroundId,
    required File tgvFile,
  }) async {
    final Directory backgroundsDirectory = Directory(
        '${(await getApplicationSupportDirectory()).path}/backgrounds');
    if (!backgroundsDirectory.existsSync()) {
      await backgroundsDirectory.create();
    }

    final File resolvedBackgroundFile = File(
      '${backgroundsDirectory.path}/pattern_$backgroundId}.png',
    );
    if (resolvedBackgroundFile.existsSync()) {
      return resolvedBackgroundFile;
    }

    final Uint8List svgBytes = _decodeArchive(tgvFile);
    final Uint8List png = await _svgToPng(svgBytes);
    await resolvedBackgroundFile.writeAsBytes(png);
    return resolvedBackgroundFile;
  }

  Future<Uint8List> _svgToPng(Uint8List svgFile) async {
    final DrawableRoot svgDrawableRoot = await svg.fromSvgBytes(svgFile, '');

    // TODO magic numbers
    const double width = 155 * 5;
    const double height = 320 * 5;
    final ui.Picture picture =
        svgDrawableRoot.toPicture(size: const Size(width, height));

    final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    final ByteData bytes =
        (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return bytes.buffer.asUint8List();
  }

  Uint8List _decodeArchive(File file) {
    final InputFileStream inputStream = InputFileStream(file.path);
    final List<int> archive = GZipDecoder().decodeBuffer(inputStream);
    return Uint8List.fromList(archive);
  }
}
