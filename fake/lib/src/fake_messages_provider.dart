import 'package:fake/src/utils.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeMessagesProvider {
  Future<td.Message> getMessageVideo1() async =>
      getMessageByFileName('message_video_1');

  Future<td.Message> getMessageByFileName(String fileName) async =>
      getMessage(fileName);
}
