import 'package:demo/src/message_data.dart';

class MessageBundle {
  MessageBundle({required this.messages, required this.name});

  final String name;

  final List<MessageData> messages;
}
