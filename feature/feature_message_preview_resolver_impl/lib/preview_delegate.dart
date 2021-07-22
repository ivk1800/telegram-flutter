import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:tdlib/td_api.dart' as td;

abstract class IPreviewDelegate {
  Future<MessagePreviewData> resolveForAnimation(
    td.Message message,
    td.MessageAnimation animation,
  );

  Future<MessagePreviewData> resolveForText(
    td.Message message,
    td.MessageText animation,
  );
}
