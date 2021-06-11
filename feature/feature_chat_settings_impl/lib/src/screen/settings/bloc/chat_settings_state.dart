import 'package:coreui/coreui.dart';
import 'package:equatable/equatable.dart';

abstract class ChatSettingsState extends Equatable {
  const ChatSettingsState();

  @override
  List<Object> get props => <Object>[];
}

class DefaultState extends ChatSettingsState {
  const DefaultState();
}
