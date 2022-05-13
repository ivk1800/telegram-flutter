import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:pubspec_parse/pubspec_parse.dart' as pp;

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

      final pp.Pubspec pubspec = pp.Pubspec.parse(lines);

      final bool isFlutter =
          (pubspec.environment?.keys.any((String env) => env == 'flutter') ??
                  false) ||
              pubspec.dependencies.keys.any((String env) => env == 'flutter');
      final bool withBuildRunner = pubspec.devDependencies.keys
          .any((String env) => env == 'build_runner');

      final bool withTest =
          pubspec.devDependencies.keys.any((String env) => env == 'test');

      List<Dependency> _map(Map<String, pp.Dependency> dependencies) {
        return dependencies.keys
            .where((String key) => dependencies[key] is pp.HostedDependency)
            .map((String key) {
          return Dependency(
            name: key,
            version:
                (dependencies[key] as pp.HostedDependency).version.toString(),
          );
        }).toList();
      }

      final List<Dependency> dependencies = _map(pubspec.dependencies);
      final List<Dependency> devDependencies = _map(pubspec.devDependencies);
      return DartProject(
        name: pubspec.name,
        path: e.path.replaceAll('pubspec.yaml', ''),
        isFlutter: isFlutter,
        withTest: withTest,
        withBuildRunner: withBuildRunner,
        dependencies: dependencies + devDependencies,
      );
    },
  );
  return Future.wait(futures);
}
