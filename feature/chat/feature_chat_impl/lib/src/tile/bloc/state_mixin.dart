import 'dart:async';

import 'package:feature_chat_impl/src/tile/bloc/message_bloc.dart';
import 'package:feature_chat_impl/src/tile/model/base_message_tile_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

mixin StateMixin<Model extends BaseMessageTileModel, State>
    on MessageBloc<Model> {
  final BehaviorSubject<State> _stateSubject = BehaviorSubject<State>();

  Stream<State> get state => _stateSubject;

  @override
  void dispatchModel(Model model) {
    assert(!_stateSubject.isClosed, 'message bloc is disposed!');
    super.dispatchModel(model);
  }

  @protected
  void setState(State state) {
    assert(!_stateSubject.isClosed, 'message bloc is disposed!');
    if (state != _stateSubject.valueOrNull) {
      _stateSubject.add(state);
    }
  }
}
