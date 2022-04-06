import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:console/console.dart';
import 'package:rxdart/rxdart.dart';

import 'command.dart';

Future<void> runCommands({
  required List<Command> commands,
  required bool withOutputs,
}) async {
  int count = 0;

  final int startMillis = DateTime.now().millisecondsSinceEpoch;

  await Stream<Command>.fromIterable(commands).flatMap<void>(
    (Command command) {
      TextPen()
        ..setColor(Color.YELLOW)
        ..text('start: ${command.name}')
        ..print();
      return Stream<void>.fromFuture(
        _runCommand(
          workingDirectory: command.workingDirectory,
          executable: command.executable,
          arguments: command.arguments,
          withOutputs: withOutputs,
        ).then((void value) {
          TextPen()
            ..setColor(Color.GREEN)
            ..text('${++count}/${commands.length}: ${command.name}')
            ..print();
          return value;
        }),
      );
    },
    maxConcurrent: Platform.numberOfProcessors,
  ).toList();

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

Future<void> _runCommand({
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
