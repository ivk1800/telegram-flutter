import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_event.freezed.dart';

@freezed
@immutable
class LogoutEvent with _$LogoutEvent {
  const factory LogoutEvent.tap(TapType tap) = Tap;
}

enum TapType {
  addAnotherAccount,
  setPasscode,
  clearCache,
  changePhoneNumber,
  contactSupport,
  logOut,
}
