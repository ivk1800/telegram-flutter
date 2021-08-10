import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => <Object>[];
}

class SubmitPhoneTap extends AuthEvent {
  const SubmitPhoneTap({required this.number});

  final String number;

  @override
  List<Object> get props => <Object>[number];
}

class SubmitCodeTap extends AuthEvent {
  const SubmitCodeTap({required this.code});

  final String code;

  @override
  List<Object> get props => <Object>[code];
}

class StopVerificationTap extends AuthEvent {
  const StopVerificationTap();
}

class ChangeCountryTap extends AuthEvent {
  const ChangeCountryTap();
}

class CountryCodeChanged extends AuthEvent {
  const CountryCodeChanged({
    required this.code,
  });

  final String code;

  @override
  List<Object> get props => <Object>[code];
}
