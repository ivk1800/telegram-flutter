import 'package:collection/collection.dart';
import 'package:feature_chat_impl/src/tile/model/base_message_tile_model.dart';
import 'package:tile/tile.dart';

abstract class IMessagesBundle {
  int get length;

  ITileModel operator [](int i);

  int? indexOf(int messageId);

  factory IMessagesBundle.fromList(List<ITileModel> models) {
    return _MessagesBundle.fromList(models);
  }
}

class _MessagesBundle implements IMessagesBundle {
  _MessagesBundle._(this.models, this.indexesInfo);

  factory _MessagesBundle.fromList(List<ITileModel> models) {
    final Iterable<MapEntry<int, int>> indexesInfo = models
        .whereType<BaseMessageTileModel>()
        .cast<BaseMessageTileModel>()
        .mapIndexed(
          (int index, BaseMessageTileModel element) =>
              MapEntry<int, int>(element.id, index),
        );
    return _MessagesBundle._(models, Map<int, int>.fromEntries(indexesInfo));
  }

  final List<ITileModel> models;
  final Map<int, int> indexesInfo;

  @override
  ITileModel operator [](int i) => models[i];

  @override
  int get length => models.length;

  @override
  int? indexOf(int messageId) => indexesInfo[messageId];
}
