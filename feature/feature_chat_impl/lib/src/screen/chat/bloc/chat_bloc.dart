import 'dart:async';

import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tile/tile.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required ChatArgs args,
    required IChatScreenRouter router,
    required IChatHeaderInfoInteractor headerInfoInteractor,
    required ChatMessagesInteractor messagesInteractor,
  })  : _args = args,
        _headerInfoInteractor = headerInfoInteractor,
        _router = router,
        _messagesInteractor = messagesInteractor,
        super(ChatState(
          headerState: HeaderState(
            info: headerInfoInteractor.current,
          ),
          bodyState: const LoadingBodyState(),
        )) {
    _initCompositeStateSubscription();
    _messagesInteractor.init(_args.chatId);
  }

  final ChatArgs _args;
  final ChatMessagesInteractor _messagesInteractor;
  final IChatHeaderInfoInteractor _headerInfoInteractor;
  final IChatScreenRouter _router;
  StreamSubscription<dynamic>? _compositeStateSubscription;

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    switch (event.runtimeType) {
      case ScrollEvent:
        {
          _messagesInteractor.loadMore();
          break;
        }
      case SenderTapEvent:
        {
          _router.toChatProfile((event as SenderTapEvent).senderId);
          break;
        }
    }
  }

  @override
  Future<void> close() {
    _messagesInteractor.dispose();
    _compositeStateSubscription?.cancel();
    return super.close();
  }

  void _initCompositeStateSubscription() {
    _compositeStateSubscription =
        Rx.combineLatest2<BodyState, HeaderState, ChatState>(
      _messagesInteractor.messagesStream
          .map<BodyState>(
            (List<ITileModel> event) => DataBodyState(tiles: event),
          )
          .startWith(const LoadingBodyState()),
      _headerInfoInteractor.infoStream
          .startWith(_headerInfoInteractor.current)
          .map((ChatHeaderInfo event) => HeaderState(
                info: event,
              )),
      (BodyState body, HeaderState header) =>
          ChatState(headerState: header, bodyState: body),
    ).listen((ChatState newState) {
      emit(newState);
    });
  }
}
