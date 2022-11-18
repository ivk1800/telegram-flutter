import 'package:chat_kit/chat_kit.dart';

class FakeChatBackgroundManager implements ChatBackgroundManager {
  const FakeChatBackgroundManager({required this.chatBackgroundFunc});

  final ChatBackground Function()? chatBackgroundFunc;

  @override
  ChatBackground get background =>
      chatBackgroundFunc?.call() ?? (throw UnimplementedError());

  @override
  Stream<ChatBackground> get backgroundStream =>
      Stream<ChatBackground>.value(background);

  @override
  void dispose() {}

  @override
  void setActiveBackground(int id) {}
}
