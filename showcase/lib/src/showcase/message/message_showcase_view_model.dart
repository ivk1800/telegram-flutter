import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:showcase/src/showcase/message/message_data.dart';
import 'package:showcase/src/showcase/message/message_showcase_state.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'message_bundle.dart';

class MessageShowcaseViewModel extends BaseViewModel {
  MessageShowcaseViewModel({
    required MessageBundle messageBundle,
    required MessageTileMapper messageTileMapper,
  })  : _messageBundle = messageBundle,
        _messageTileMapper = messageTileMapper {
    final Stream<MessageShowcaseState> stateStream =
        Stream<MessageData>.fromIterable(_messageBundle.messages)
            .asyncMap((MessageData data) async {
              final td.Message message = await data.messageFactory.call();
              return _messageTileMapper.mapToTileModel(message);
            })
            .bufferCount(100)
            .map((List<ITileModel> items) {
              return MessageShowcaseState(items: items);
            })
            .startWith(const MessageShowcaseState.loading());
    subscribe(stateStream, _stateSubject.add);
  }

  final MessageBundle _messageBundle;
  final MessageTileMapper _messageTileMapper;

  final BehaviorSubject<MessageShowcaseState> _stateSubject =
      BehaviorSubject<MessageShowcaseState>.seeded(
    const MessageShowcaseState.loading(),
  );

  Stream<MessageShowcaseState> get state => _stateSubject;
  Stream<String> get title => Stream<String>.value(_messageBundle.name);

  @override
  void dispose() {
    _stateSubject.close();
    super.dispose();
  }
}
