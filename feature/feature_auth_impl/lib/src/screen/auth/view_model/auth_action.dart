import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_action.freezed.dart';

@immutable
@freezed
class AuthAction with _$AuthAction {
  const factory AuthAction.setCountryCode({
    required int code,
  }) = _SetCountryCode;

  const factory AuthAction.setPhoneNumberMask({
    required String mask,
  }) = _SetPhoneNumberMask;

  const factory AuthAction.resetCode() = _ResetCode;
}

//
// abstract class AuthAction {}
//
// class SetCountryCode implements AuthAction {
//   const SetCountryCode({required this.code});
//
//   final int code;
// }
//
// class SetPhoneNumberMask implements AuthAction {
//   const SetPhoneNumberMask({required this.mask});
//
//   final String mask;
// }
//
// class ResetCode implements AuthAction {
//   const ResetCode();
// }
