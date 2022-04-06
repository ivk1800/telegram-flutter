class Command {
  Command({
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
