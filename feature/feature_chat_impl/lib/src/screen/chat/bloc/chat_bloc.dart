import 'package:coreui/coreui.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(
      {required ChatArgs args,
      required IChatScreenRouter router,
      required ChatMessagesInteractor messagesInteractor})
      : _args = args,
        _router = router,
        _messagesInteractor = messagesInteractor,
        super(const LoadingState()) {
    _messagesInteractor.messagesStream.listen((List<ITileModel> tiles) {
      emit(DefaultState(tiles: tiles));
    });
    _messagesInteractor.init(_args.chatId);
  }

  final ChatArgs _args;
  final ChatMessagesInteractor _messagesInteractor;
  final IChatScreenRouter _router;

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    switch (event.runtimeType) {
      case ScrollEvent:
        {
          _messagesInteractor.loadMore();
        }
    }
  }

  @override
  Future<void> close() {
    _messagesInteractor.dispose();
    return super.close();
  }
}
