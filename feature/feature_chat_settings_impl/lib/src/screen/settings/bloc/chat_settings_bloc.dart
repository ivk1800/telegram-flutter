import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:feature_chat_settings_impl/src/chat_settings_screen_router.dart';

import 'chat_settings_event.dart';
import 'chat_settings_state.dart';

class ChatSettingsBloc extends Bloc<ChatSettingsEvent, ChatSettingsState> {
  ChatSettingsBloc({required IChatSettingsScreenRouter router})
      : _router = router,
        super(const DefaultState());
  final IChatSettingsScreenRouter _router;

  @override
  Stream<ChatSettingsState> mapEventToState(ChatSettingsEvent event) async* {
    if (event is ActionEvent) {
      _handleActionEvent(event);
      return;
    }
  }

  void _handleActionEvent(ActionEvent event) {
    switch (event.runtimeType) {
      case StickersAndMasksTap:
        _router.toStickersAndMasks();
        return;
      case WallpapersTap:
        _router.toWallPapers();
        return;
    }
  }
}
