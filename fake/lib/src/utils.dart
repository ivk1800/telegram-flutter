import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:td_api/td_api.dart' as td;

Future<td.Message> getMessage(String fileName) async {
  final String rawJson = await rootBundle
      .loadString('packages/fake/assets/messages/$fileName.json');
  return td.Message.fromJson(
    json.decoder.convert(rawJson) as Map<String, dynamic>,
  )!;
}

Future<td.User> getUser(String fileName) async {
  final String rawJson =
      await rootBundle.loadString('packages/fake/assets/users/$fileName.json');
  return td.User.fromJson(
    json.decoder.convert(rawJson) as Map<String, dynamic>,
  )!;
}

Future<File> readFileFromAssets({
  required String key,
  required String fileName,
}) async {
  final ByteData sticker = await rootBundle.load(key);

  final File file = File('${Directory.systemTemp.path}/$fileName');
  await file.writeAsBytes(
    sticker.buffer.asUint8List(
      sticker.offsetInBytes,
      sticker.lengthInBytes,
    ),
  );
  return file;
}
