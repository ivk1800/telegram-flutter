import 'package:td_api/td_api.dart' as td;

class MessageData {
  const MessageData({required this.name, required this.messageFactory});

  final String name;

  final Future<td.Message> Function() messageFactory;
}
