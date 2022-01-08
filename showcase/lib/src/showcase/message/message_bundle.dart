import 'package:showcase/src/showcase/message/message_data.dart';

class MessageBundle {
  MessageBundle({required this.messages, required this.name});

  final String name;

  final List<MessageData> messages;
}
