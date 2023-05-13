import 'dart:async';

import 'package:args/args.dart';
import 'package:console/console.dart';
import 'package:tools/strings_provider_generator.dart';
import 'command/pub_get_command.dart';
import 'dart_project.dart';
import 'dependencies_info.dart';
import 'utils.dart';

Future<void> main(List<String> arguments) async {
  final ArgParser parser = ArgParser()
    ..addOption('work-directory')
    ..addOption('withOutputs', defaultsTo: 'false')
    ..addCommand('get')
    ..addCommand('upgrade')
    ..addCommand('gen')
    ..addCommand('analyze')
    ..addCommand('validate_dependencies')
    ..addCommand('generate_stings_provider')
    ..addCommand('dependencies_info')
    ..addCommand('test');

  final ArgResults results = parser.parse(arguments);
  final String? command = results.command?.name;
  final String workDirectory = results['work-directory']! as String;
  final bool withOutputs = results['withOutputs'] == 'true';

  final List<DartProject> dartProjects = (await getDartProjects(workDirectory))
    ..sort();

  if (command == 'get') {
    Console.write('run packages get\n');
    await runPubGetCommandForProjects(
      withOutputs: withOutputs,
      dartProjects: dartProjects,
    );
  } else if (command == 'upgrade') {
    Console.write('run pub upgrade\n');
    await runPubUpgradeCommandForProjects(
      withOutputs: withOutputs,
      dartProjects: dartProjects,
    );
  } else if (command == 'gen') {
    Console.write('run gen\n');
    await runBuildRunnerCommandForProjects(
      withOutputs: withOutputs,
      dartProjects: dartProjects
          .where((DartProject project) => project.withBuildRunner)
          .toList(),
    );
  } else if (command == 'analyze') {
    Console.write('run analyze\n');
    await runAnalyzeCommandForProjects(
      withOutputs: withOutputs,
      dartProjects: dartProjects,
    );
  } else if (command == 'test') {
    Console.write('run test\n');
    await runTestCommandForProjects(
      withOutputs: withOutputs,
      dartProjects: dartProjects
          .where((DartProject project) => project.withTest)
          .toList(),
    );
  } else if (command == 'validate_dependencies') {
    Console.write('run dependencies validator\n');
    await runValidateDependenciesCommandForProjects(
      withOutputs: withOutputs,
      dartProjects: dartProjects,
    );
  } else if (command == 'generate_stings_provider') {
    generateStringsProvider(workDirectory);
  } else if (command == 'dependencies_info') {
    await printDependenciesInfo(workDirectory);
  }
}
