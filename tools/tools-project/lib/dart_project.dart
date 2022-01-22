class DartProject {
  DartProject({
    required this.name,
    required this.path,
    required this.isFlutter,
    required this.withBuildRunner,
    required this.withTest,
  });

  final String name;
  final String path;
  final bool isFlutter;
  final bool withBuildRunner;
  final bool withTest;

  @override
  String toString() {
    return 'path=$path, isFlutter=$isFlutter, isBuildRunner=$withBuildRunner';
  }
}
