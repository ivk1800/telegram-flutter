import 'package:flutter/foundation.dart';

@immutable
class OrderedChat implements Comparable<OrderedChat> {
  const OrderedChat({
    required this.chatId,
    required this.order,
  });

  final int order;
  final int chatId;

  @override
  int compareTo(OrderedChat o) {
    if (order != o.order) {
      return o.order < order ? -1 : 1;
    }
    if (chatId != o.chatId) {
      return o.chatId < chatId ? -1 : 1;
    }
    return 0;
  }
}
