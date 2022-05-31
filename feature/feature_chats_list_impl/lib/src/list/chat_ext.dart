import 'package:collection/collection.dart';
import 'package:tdlib/td_api.dart' as td;

extension ChatExt on td.Chat {
  td.ChatPosition? getPositionByChatList(td.ChatList chatList) {
    return positions.firstWhereOrNull((td.ChatPosition position) {
      return position.list == chatList;
    });
  }
}
