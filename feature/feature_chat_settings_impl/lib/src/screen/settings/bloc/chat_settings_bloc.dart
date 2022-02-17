import 'package:feature_chat_settings_impl/src/chat_settings_screen_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_settings_event.dart';
import 'chat_settings_state.dart';

class ChatSettingsBloc extends Bloc<ChatSettingsEvent, ChatSettingsState> {
  ChatSettingsBloc({required IChatSettingsScreenRouter router})
      : _router = router,
        super(const ChatSettingsState()) {
    on<StickersAndMasksTap>(_onStickersAndMasksTap);
    on<WallpapersTap>(_onWallpapersTap);
  }

  final IChatSettingsScreenRouter _router;

  void _onStickersAndMasksTap(
    StickersAndMasksTap event,
    Emitter<ChatSettingsState> emit,
  ) {
    _router.toStickersAndMasks();
  }

  void _onWallpapersTap(WallpapersTap event, Emitter<ChatSettingsState> emit) {
    _router.toWallPapers();
  }
}
