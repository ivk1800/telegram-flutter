import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:pubspec_parse/pubspec_parse.dart';

import 'dart_project.dart';

Future<List<DartProject>> getDartProjects(String directory) async {
  final Iterable<FileSystemEntity> pubspecEntities = Directory(directory)
      .listSync(
        recursive: true,
        followLinks: false,
      )
      .where(
        (FileSystemEntity entity) =>
            entity is File && entity.path.endsWith('pubspec.yaml'),
      );

  final Iterable<Future<DartProject>> futures = pubspecEntities.map(
    (FileSystemEntity e) async {
      final String lines =
          await File(e.path).openRead().map(utf8.decode).single;

      final Pubspec pubspec = Pubspec.parse(lines);

      final bool isFlutter =
          (pubspec.environment?.keys.any((String env) => env == 'flutter') ??
                  false) ||
              pubspec.dependencies.keys.any((String env) => env == 'flutter');
      final bool withBuildRunner = pubspec.devDependencies.keys
          .any((String env) => env == 'build_runner');

      final bool withTest =
          pubspec.devDependencies.keys.any((String env) => env == 'test');
      return DartProject(
        name: pubspec.name,
        path: e.path.replaceAll('pubspec.yaml', ''),
        isFlutter: isFlutter,
        withTest: withTest,
        withBuildRunner: withBuildRunner,
      );
    },
  );
  return Future.wait(futures);
}
