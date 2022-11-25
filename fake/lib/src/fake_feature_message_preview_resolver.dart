import 'dart:async';

import 'package:feature_message_preview_resolver/feature_message_preview_resolver.dart';
import 'package:td_api/td_api.dart' as td;

class FakeMessagePreviewResolver implements IMessagePreviewResolver {
  const FakeMessagePreviewResolver();

  @override
  Future<MessagePreviewData> resolve(td.Message message) =>
      Completer<MessagePreviewData>().future;
}
