import 'package:feature_chat_impl/src/tile/model/base_message_tile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

abstract class MessageBloc<Model extends BaseMessageTileModel, State> {
  @protected
  Model get model {
    assert(_model != null, 'called before dispatchModel!');
    return _model!;
  }

  Model? _model;

  int get id => model.id;

  bool get isOutgoing => model.isOutgoing;

  final BehaviorSubject<State> _stateSubject = BehaviorSubject<State>();

  Stream<State> get state => _stateSubject;

  @protected
  void setState(State state) {
    assert(!_stateSubject.isClosed, 'message bloc is disposed!');
    if (state != _stateSubject.valueOrNull) {
      _stateSubject.add(state);
    }
  }

  // ignore: use_setters_to_change_properties
  void dispatchModel(Model model) {
    assert(!_stateSubject.isClosed, 'message bloc is disposed!');
    if (_model != model) {
      _model = model;
      onModelChanged();
    }
  }

  @protected
  void onModelChanged();

  @mustCallSuper
  void onDispose() {
    _stateSubject.close();
  }
}
