import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:tdlib/td_api.dart' as td;

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
