import 'chat_header_info.dart';

abstract class IChatHeaderInfoInteractor {
  Stream<ChatHeaderInfo> get infoStream;

  ChatHeaderInfo get current;
}
