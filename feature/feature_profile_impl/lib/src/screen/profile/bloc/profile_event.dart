import 'package:equatable/equatable.dart';
import 'package:feature_profile_impl/src/shared_content_type.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => <Object>[];
}

abstract class ActionEvent extends ProfileEvent {
  const ActionEvent();
}

class NotificationToggleTap extends ActionEvent {
  const NotificationToggleTap();
}

class NotificationTap extends ActionEvent {
  const NotificationTap();
}

class MessagesTap extends ActionEvent {
  const MessagesTap({required this.type});

  final SharedContentType type;
}
