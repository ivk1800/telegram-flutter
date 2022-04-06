import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

@immutable
class DartProject implements Comparable<DartProject> {
  const DartProject({
    required this.name,
    required this.path,
    required this.isFlutter,
    required this.withBuildRunner,
    required this.withTest,
    required this.dependencies,
  });

  final String name;
  final String path;
  final bool isFlutter;
  final bool withBuildRunner;
  final bool withTest;
  final List<Dependency> dependencies;

  @override
  String toString() {
    return 'path=$path, isFlutter=$isFlutter, isBuildRunner=$withBuildRunner';
  }

  @override
  int compareTo(DartProject other) => name.compareTo(other.name);
}

@immutable
class Dependency {
  const Dependency({
    required this.name,
    required this.version,
  });

  final String version;
  final String name;

  @override
  String toString() => 'name=$name, version=$version';

  @override
  int get hashCode => hash2(version, name);

  @override
  bool operator ==(Object other) =>
      other is Dependency && (other.name == name && other.version == version);
}
