import 'package:feature_chat_impl/src/tile/model/base_message_tile_model.dart';
import 'package:flutter/foundation.dart';

abstract class MessageBloc<Model extends BaseMessageTileModel> {
  Model get model {
    assert(_model != null, 'called before dispatchModel!');
    return _model!;
  }

  Model? _model;

  int get id => model.id;

  bool get isOutgoing => model.isOutgoing;

  // ignore: use_setters_to_change_properties
  void dispatchModel(Model model) {
    if (_model != model) {
      _model = model;
      onModelChanged();
    }
  }

  @protected
  void onModelChanged();

  @mustCallSuper
  void onDispose() {}
}
