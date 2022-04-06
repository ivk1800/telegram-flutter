import 'dart:async';

import '../dart_project.dart';
import 'command.dart';
import 'command_runner.dart';

Future<void> runPubGetCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<Command> commands = dartProjects.map((DartProject project) {
    return Command(
      name: project.name,
      workingDirectory: project.path,
      executable: project.isFlutter ? 'flutter' : 'dart',
      arguments: project.isFlutter
          ? <String>['packages', 'get']
          : <String>['pub', 'get'],
    );
  }).toList();
  await runCommands(commands: commands, withOutputs: withOutputs);
}

Future<void> runBuildRunnerCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<Command> commands = dartProjects.map((DartProject project) {
    return Command(
      name: project.name,
      workingDirectory: project.path,
      executable: project.isFlutter ? 'flutter' : 'dart',
      arguments: project.isFlutter
          ? <String>[
              'packages',
              'pub',
              'run',
              'build_runner',
              'build',
              '--delete-conflicting-outputs',
            ]
          : <String>[
              'run',
              'build_runner',
              'build',
              '--delete-conflicting-outputs',
            ],
    );
  }).toList();
  await runCommands(commands: commands, withOutputs: withOutputs);
}

Future<void> runAnalyzeCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<Command> commands = dartProjects.map((DartProject project) {
    return Command(
      name: project.name,
      workingDirectory: project.path,
      executable: project.isFlutter ? 'flutter' : 'dart',
      arguments: <String>[
        'analyze',
        '--fatal-infos',
      ],
    );
  }).toList();
  await runCommands(commands: commands, withOutputs: withOutputs);
}

Future<void> runTestCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<Command> commands = dartProjects.map((DartProject project) {
    return Command(
      name: project.name,
      workingDirectory: project.path,
      executable: 'flutter',
      arguments: const <String>['test'],
    );
  }).toList();
  await runCommands(commands: commands, withOutputs: withOutputs);
}

Future<void> runValidateDependenciesCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<Command> commands = dartProjects.map((DartProject project) {
    return Command(
      name: project.name,
      workingDirectory: project.path,
      executable: 'dart',
      arguments: const <String>[
        'run',
        'dependency_validator',
      ],
    );
  }).toList();
  await runCommands(commands: commands, withOutputs: withOutputs);
}
