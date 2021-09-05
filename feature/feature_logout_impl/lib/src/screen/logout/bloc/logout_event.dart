import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object> get props => <Object>[];
}

class TapEvent extends LogoutEvent {
  const TapEvent(this.tap);

  final TapType tap;
}

enum TapType {
  addAnotherAccount,
  setPasscode,
  clearCache,
  changePhoneNumber,
  contactSupport,
  logOut,
}
