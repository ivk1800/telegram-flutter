abstract class AuthAction {}

class SetCountryCode implements AuthAction {
  const SetCountryCode({required this.code});

  final int code;
}

class SetPhoneNumberMask implements AuthAction {
  const SetPhoneNumberMask({required this.mask});

  final String mask;
}

class ResetCode implements AuthAction {
  const ResetCode();
}
