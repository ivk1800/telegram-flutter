import 'package:equatable/equatable.dart';

abstract class ChatSettingsEvent extends Equatable {
  const ChatSettingsEvent();

  @override
  List<Object> get props => <Object>[];
}

abstract class ActionEvent extends ChatSettingsEvent {
  const ActionEvent();
}

class StickersAndMasksTap extends ActionEvent {
  const StickersAndMasksTap();
}

class LoadingEvent extends ChatSettingsEvent {
  const LoadingEvent();
}
