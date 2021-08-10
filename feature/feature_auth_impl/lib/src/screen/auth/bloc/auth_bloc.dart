import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_auth_api/feature_auth_api.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_auth_impl/src/screen/auth/bloc/auth_action.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required ILocalizationManager localizationManager,
    required IAuthFeatureRouter router,
    required ICountryRepository countryRepository,
    required IAuthenticationManager authenticationManager,
  })  : _localizationManager = localizationManager,
        _countryRepository = countryRepository,
        _router = router,
        _authenticationManager = authenticationManager,
        super(
          PhoneNumberState(
            title: localizationManager.getString('YourPhone'),
            countryTitle: localizationManager.getString('ChooseCountry'),
            blockInteraction: false,
          ),
        );

  final ILocalizationManager _localizationManager;
  final IAuthFeatureRouter _router;
  final ICountryRepository _countryRepository;
  final IAuthenticationManager _authenticationManager;
  final PublishSubject<AuthAction> _actionSubject =
      PublishSubject<AuthAction>();

  Stream<AuthAction> get actions => _actionSubject;

  String? _phoneNumber;
  Country? _country;

  String _getCountryTitle() {
    if (_country == null) {
      return _getString('ChooseCountry');
    }
    return _country!.name;
  }

  String _getMask() => _country?.phoneFormat ?? '';

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event.runtimeType) {
      case StopVerificationTap:
        {
          yield* _handleStopVerificationTap(event as StopVerificationTap);
          break;
        }
      case ChangeCountryTap:
        {
          yield* _handleChangeCountryTap(event as ChangeCountryTap);
          break;
        }
      case SubmitPhoneTap:
        {
          yield* _handleSubmitPhoneTap(event as SubmitPhoneTap);
          break;
        }
      case SubmitCodeTap:
        {
          // todo prevent resend code after success auth
          // TextEditingController triggered again
          if (state is CodeState && !state.blockInteraction) {
            yield* _handleSubmitCodeTap(event as SubmitCodeTap);
          }
          break;
        }
      case CountryCodeChanged:
        {
          yield* _handleCountryCodeChanged(event as CountryCodeChanged);
          break;
        }
    }
  }

  @override
  Future<void> close() {
    _actionSubject.close();
    return super.close();
  }

  PhoneNumberState _getPhoneState() => state as PhoneNumberState;

  CodeState _getCodeState() => state as CodeState;

  String _getString(String key) => _localizationManager.getString(key);

  Stream<AuthState> _handleSubmitCodeTap(SubmitCodeTap event) async* {
    yield _getCodeState().copy(
      blockInteraction: true,
    );
    await _authenticationManager.checkAuthenticationCode(event.code).then(
        (td.Ok value) {
      // nothing
      return value;
    }, onError: (dynamic e) {
      emit(_getCodeState().copy(
        blockInteraction: false,
      ));
      _actionSubject.add(const ResetCode());
      _router.toDialog(
        title: _getString('AppName'),
        body: TextBody(text: _tryConvertToHumanError(e)),
        actions: <Action>[
          Action(text: _getString('OK')),
        ],
      );
    });
  }

  Stream<AuthState> _handleSubmitPhoneTap(SubmitPhoneTap event) async* {
    yield _getPhoneState().copy(
      blockInteraction: true,
    );
    await _authenticationManager
        .setAuthenticationPhoneNumber(event.number)
        .then((td.Ok value) {
      _phoneNumber = event.number;
      emit(CodeState(
        blockInteraction: false,
        // todo format number
        title: _phoneNumber!,
      ));
      return value;
    }, onError: (dynamic e) {
      emit(_getPhoneState().copy(
        blockInteraction: false,
      ));
      _router.toDialog(
        title: _getString('AppName'),
        body: TextBody(text: _tryConvertToHumanError(e)),
        actions: <Action>[
          Action(text: _getString('OK')),
        ],
      );
    });
  }

  // todo implement human texts
  String _tryConvertToHumanError(dynamic error) {
    if (error is TdError) {
      return error.error.message;
    }
    return error.toString();
  }

  Stream<AuthState> _handleCountryCodeChanged(CountryCodeChanged event) async* {
    final String codeString = event.code;

    if (codeString.isEmpty) {
      _country = null;
      yield _getPhoneState().copy(
        countryTitle: _getCountryTitle(),
        phoneNumberMask: _getMask(),
      );
      _actionSubject.add(SetPhoneNumberMask(mask: _getMask()));
      return;
    }

    final int code = int.parse(codeString);

    if (_country != null && _country!.code == code) {
      return;
    }

    final Country? newCountry = await _countryRepository.findByCode(code: code);

    if (newCountry == null) {
      _country = null;
      yield _getPhoneState().copy(
        countryTitle: _getString('WrongCountry'),
      );
    } else {
      _country = newCountry;
      yield _getPhoneState().copy(
        countryTitle: _getCountryTitle(),
        phoneNumberMask: _getMask(),
      );
    }
    _actionSubject.add(SetPhoneNumberMask(mask: _getMask()));
  }

  Stream<AuthState> _handleChangeCountryTap(ChangeCountryTap event) async* {
    _router.toChooseCountry((Country country) {
      _country = country;
      emit(_getPhoneState().copy(
        countryTitle: _getCountryTitle(),
        phoneNumberMask: _getMask(),
      ));
      _actionSubject.add(SetCountryCode(code: country.code));
      _actionSubject.add(SetPhoneNumberMask(mask: _getMask()));
    });
  }

  Stream<AuthState> _handleStopVerificationTap(
    StopVerificationTap event,
  ) async* {
    _router.toDialog(
        title: _getString('AppName'),
        body: TextBody(text: _getString('StopVerification')),
        actions: <Action>[
          Action(
            text: _getString('Stop'),
            callback: () {
              _phoneNumber = null;
              emit(
                PhoneNumberState(
                  title: _getString('YourPhone'),
                  countryTitle: _getCountryTitle(),
                  blockInteraction: false,
                ),
              );
              return true;
            },
          ),
          Action(
            text: _getString('Continue'),
            callback: () {
              return true;
            },
          ),
        ]);
  }
}
