import 'package:tdlib/td_api.dart' as td;
import 'package:coreui/coreui.dart';

class MessageTileModel implements ITileModel {
  const MessageTileModel({
    required this.message,
  });

  final td.Message message;
}
