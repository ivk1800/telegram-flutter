import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:console/console.dart';
import 'package:rxdart/rxdart.dart';

import 'command.dart';

Future<void> runCommands({
  required List<Command> commands,
  required bool withOutputs,
  bool withRetry = true,
}) async {
  int count = 0;

  final int startMillis = DateTime.now().millisecondsSinceEpoch;

  final List<_CommandResultWrapper> failedCommands =
      (await Stream<Command>.fromIterable(commands)
              .flatMap<_CommandResultWrapper>(
    (Command command) {
      TextPen()
        ..setColor(Color.YELLOW)
        ..text('start: ${command.name}')
        ..print();
      return Stream<_CommandResultWrapper>.fromFuture(
        _runCommand(
          workingDirectory: command.workingDirectory,
          executable: command.executable,
          arguments: command.arguments,
          name: command.name,
          throwOnFail: !withRetry,
          withOutputs: withOutputs,
        ).then((_CommandResult value) {
          TextPen()
            ..setColor(Color.GREEN)
            ..text('${++count}/${commands.length}: ${command.name}')
            ..print();
          return _CommandResultWrapper(
            command: command,
            result: value,
          );
        }),
      );
    },
    maxConcurrent: 4,
  ).toList())
          .where(
            (_CommandResultWrapper result) =>
                result.result == _CommandResult.failed,
          )
          .toList();

  if (failedCommands.isNotEmpty) {
    TextPen()
      ..setColor(Color.YELLOW)
      ..text('retry...')
      ..print();
    await runCommands(
      commands: failedCommands
          .map((_CommandResultWrapper result) => result.command)
          .toList(),
      withOutputs: withOutputs,
      withRetry: false,
    );
  }

  final int endMillis = DateTime.now().millisecondsSinceEpoch;
  final Duration duration = Duration(milliseconds: endMillis - startMillis);

  TextPen()
    ..setColor(Color.GREEN)
    ..text('complete: ${_printDuration(duration)}')
    ..print();
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  final String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return '${twoDigitMinutes}m, ${twoDigitSeconds}s';
}

Future<_CommandResult> _runCommand({
  required String workingDirectory,
  required String executable,
  required String name,
  required List<String> arguments,
  required bool withOutputs,
  required bool throwOnFail,
}) async {
  final Completer<_CommandResult> completer = Completer<_CommandResult>();

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
  ).listen(
    (List<int> event) {
      final String output = utf8.decode(event);
      lastOutputs.add(output);
      if (withOutputs && output.isNotEmpty) {
        Console.write(output);
      }
    },
    onDone: () async {
      final int exitCode = await process.exitCode;
      if (exitCode != 0) {
        if (throwOnFail) {
          if (!withOutputs && lastOutputs.isNotEmpty) {
            Console.write(lastOutputs.join('\n'));
          }
          completer.completeError('command finished with exit code $exitCode');
        } else {
          TextPen()
            ..setColor(Color.RED)
            ..text('failed: $name')
            ..print();
          completer.complete(_CommandResult.failed);
        }
      } else {
        completer.complete(_CommandResult.success);
      }
    },
    onError: (Object error) {
      completer.complete(_CommandResult.failed);
      // completer.completeError(error);
    },
  );

  return completer.future;
}

class _CommandResultWrapper {
  _CommandResultWrapper({
    required this.command,
    required this.result,
  });

  final _CommandResult result;

  final Command command;
}

enum _CommandResult {
  success,
  failed,
}
