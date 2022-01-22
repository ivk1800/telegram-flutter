import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:console/console.dart';
import 'package:rxdart/rxdart.dart';

import '../dart_project.dart';

Future<void> runPubGetCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<_Command> commands = dartProjects.map((DartProject project) {
    return _Command(
      name: project.name,
      workingDirectory: project.path,
      executable: project.isFlutter ? 'flutter' : 'dart',
      arguments: project.isFlutter
          ? <String>['packages', 'get']
          : <String>['pub', 'get'],
    );
  }).toList();
  await _run(commands: commands, withOutputs: withOutputs);
}

Future<void> runBuildRunnerCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<_Command> commands = dartProjects.map((DartProject project) {
    return _Command(
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
  await _run(commands: commands, withOutputs: withOutputs);
}

Future<void> runAnalyzeCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<_Command> commands = dartProjects.map((DartProject project) {
    return _Command(
      name: project.name,
      workingDirectory: project.path,
      executable: project.isFlutter ? 'flutter' : 'dart',
      arguments: <String>[
        'analyze',
        '--fatal-infos',
      ],
    );
  }).toList();
  await _run(commands: commands, withOutputs: withOutputs);
}

Future<void> runTestCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<_Command> commands = dartProjects.map((DartProject project) {
    return _Command(
      name: project.name,
      workingDirectory: project.path,
      executable: 'flutter',
      arguments: const <String>['test'],
    );
  }).toList();
  await _run(commands: commands, withOutputs: withOutputs);
}

Future<void> runValidateDependenciesCommandForProjects({
  required List<DartProject> dartProjects,
  required bool withOutputs,
}) async {
  final List<_Command> commands = dartProjects.map((DartProject project) {
    return _Command(
      name: project.name,
      workingDirectory: project.path,
      executable: 'dart',
      arguments: const <String>[
        'run',
        'dependency_validator',
      ],
    );
  }).toList();
  await _run(commands: commands, withOutputs: withOutputs);
}

Future<void> _run({
  required List<_Command> commands,
  required bool withOutputs,
}) async {
  int count = 0;

  for (final _Command command in commands) {
    TextPen()
      ..setColor(Color.GREEN)
      ..text('${++count}/${commands.length}: ${command.name}')
      ..print();

    await runCommand(
      workingDirectory: command.workingDirectory,
      executable: command.executable,
      arguments: command.arguments,
      withOutputs: withOutputs,
    );
  }
}

Future<void> runCommand({
  required String workingDirectory,
  required String executable,
  required List<String> arguments,
  required bool withOutputs,
}) async {
  final Completer<void> completer = Completer<void>();

  final Process process = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory,
    runInShell: true,
  );

  final List<String> lastOutputs = <String>[];

  Rx.merge<List<int>>(
    <Stream<List<int>>>[
      process.stdout,
      process.stderr,
    ],
  ).listen((List<int> event) {
    final String output = utf8.decode(event);
    lastOutputs.add(output);
    if (withOutputs && output.isNotEmpty) {
      Console.write(output);
    }
  }, onDone: () async {
    final int exitCode = await process.exitCode;
    if (exitCode != 0) {
      if (!withOutputs && lastOutputs.isNotEmpty) {
        Console.write(lastOutputs.join('\n'));
      }
      completer.completeError('command finished with exit code $exitCode');
    } else {
      completer.complete(null);
    }
  }, onError: (Object error) {
    completer.completeError(error);
  });

  return completer.future;
}

class _Command {
  _Command({
    required this.name,
    required this.workingDirectory,
    required this.executable,
    required this.arguments,
  });

  final String name;
  final String executable;
  final String workingDirectory;

  final List<String> arguments;
}
