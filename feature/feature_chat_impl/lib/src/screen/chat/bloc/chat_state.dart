import 'package:coreui/coreui.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => <Object>[];
}

class DefaultState extends ChatState {
  const DefaultState({required this.tiles});

  final List<ITileModel> tiles;

  @override
  List<Object> get props => <Object>[tiles];
}

class LoadingState extends ChatState {
  const LoadingState();
}
