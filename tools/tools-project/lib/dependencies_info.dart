import 'package:collection/collection.dart';
import 'package:console/console.dart';
import 'package:tools/dart_project.dart';

import 'utils.dart';

Future<void> printDependenciesInfo(String workDirectory) async {
  final List<DartProject> projects = await getDartProjects(workDirectory);

  final Map<String, Set<Dependency>> allDependencies = projects
      .expand((DartProject element) => element.dependencies)
      .groupSetsBy((Dependency element) => element.name);

  final String result = allDependencies.keys
      .sortedBy((String key) => key)
      .map((String dep) =>
          '$dep: ${allDependencies[dep]!.map((Dependency d) => d.version).join(', ')}')
      .join('\n');

  Console.write(result);
}
