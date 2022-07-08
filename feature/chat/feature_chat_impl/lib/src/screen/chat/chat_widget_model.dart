import 'package:jugger/jugger.dart' as j;

@j.singleton
@j.disposable
class ChatWidgetModel {
  @j.inject
  ChatWidgetModel();

  void dispose() {}
}
