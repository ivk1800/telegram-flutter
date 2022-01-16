import 'package:auth_manager_api/auth_manager_api.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_auth_impl/feature_auth_impl.dart';
import 'package:feature_country_api/feature_country_api.dart';
import 'package:localization_api/localization_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tdlib/td_api.dart' as td;

import 'auth_action.dart';
import 'auth_state.dart';

class AuthViewModel extends BaseViewModel {
  AuthViewModel({
    required ILocalizationManager localizationManager,
    required IAuthFeatureRouter router,
    required ICountryRepository countryRepository,
    required IAuthenticationManager authenticationManager,
  })  : _localizationManager = localizationManager,
        _countryRepository = countryRepository,
        _router = router,
        _authenticationManager = authenticationManager;

  final ILocalizationManager _localizationManager;
  final IAuthFeatureRouter _router;
  final ICountryRepository _countryRepository;
  final IAuthenticationManager _authenticationManager;
  final PublishSubject<AuthAction> _actionSubject =
      PublishSubject<AuthAction>();
  late final BehaviorSubject<AuthState> _stateSubject =
      BehaviorSubject<AuthState>.seeded(AuthState.phoneNumber(
    title: _localizationManager.getString('YourPhone'),
    countryTitle: _localizationManager.getString('ChooseCountry'),
    blockInteraction: false,
  ));

  String? _phoneNumber;
  Country? _country;

  Stream<AuthAction> get actions => _actionSubject;

  Stream<AuthState> get state => _stateSubject;

  void onCountryCodeChanged(String code) => _handleCountryCodeChanged(code);

  void onSubmitCodeTap(String code) {
    final AuthState state = _stateSubject.value!;
    // todo prevent resend code after success auth
    // TextEditingController triggered again
    if (state is CodeState && !state.blockInteraction) {
      _handleSubmitCodeTap(code);
    }
  }

  void onChangeCountryTap() => _handleChangeCountryTap();

  void onSubmitPhoneTap(String phone) => _handleSubmitPhoneTap(phone);

  void onStopVerificationTap() => _handleStopVerificationTap();

  @override
  void dispose() {
    _actionSubject.close();
    _stateSubject.close();
  }

  String _getCountryTitle() {
    if (_country == null) {
      return _getString('ChooseCountry');
    }
    return _country!.name;
  }

  String _getMask() => _country?.phoneFormat ?? '';

  PhoneNumberState _getPhoneState() => _stateSubject.value as PhoneNumberState;

  CodeState _getCodeState() => _stateSubject.value as CodeState;

  String _getString(String key) => _localizationManager.getString(key);

  void _handleSubmitCodeTap(String code) {
    _stateSubject.add(
      _getCodeState().copyWith(
        blockInteraction: true,
      ),
    );
    _authenticationManager.checkAuthenticationCode(code).then(
      (td.Ok value) {
        // nothing
        return value;
      },
      onError: (Object e) {
        _stateSubject.add(
          _getCodeState().copyWith(
            blockInteraction: false,
          ),
        );
        _actionSubject.add(const AuthAction.resetCode());
        _router.toDialog(
          title: _getString('AppName'),
          body: Body.text(text: _tryConvertToHumanError(e)),
          actions: <Action>[
            Action(text: _getString('OK')),
          ],
        );
      },
    );
  }

  void _handleSubmitPhoneTap(String number) {
    _stateSubject.add(
      _getPhoneState().copyWith(
        blockInteraction: true,
      ),
    );
    _authenticationManager.setAuthenticationPhoneNumber(number).then(
      (td.Ok value) {
        _phoneNumber = number;
        _stateSubject.add(
          CodeState(
            blockInteraction: false,
            // todo format number
            title: _phoneNumber!,
          ),
        );
        return value;
      },
      onError: (Object e) {
        _stateSubject.add(
          _getPhoneState().copyWith(
            blockInteraction: false,
          ),
        );
        _router.toDialog(
          title: _getString('AppName'),
          body: Body.text(text: _tryConvertToHumanError(e)),
          actions: <Action>[
            Action(text: _getString('OK')),
          ],
        );
      },
    );
  }

  // todo implement human texts
  String _tryConvertToHumanError(Object error) {
    if (error is TdError) {
      return error.error.message;
    }
    return error.toString();
  }

  Future<void> _handleCountryCodeChanged(String codeString) async {
    if (codeString.isEmpty) {
      _country = null;
      _stateSubject.add(
        _getPhoneState().copyWith(
          countryTitle: _getCountryTitle(),
        ),
      );
      _actionSubject.add(AuthAction.setPhoneNumberMask(mask: _getMask()));
      return;
    }

    // todo handle error parse
    final int code = int.parse(codeString);

    if (_country != null && _country!.code == code) {
      return;
    }

    final Country? newCountry = await _countryRepository.findByCode(code: code);

    if (newCountry == null) {
      _country = null;
      _stateSubject.add(
        _getPhoneState().copyWith(
          countryTitle: _getString('WrongCountry'),
        ),
      );
    } else {
      _country = newCountry;
      _stateSubject.add(
        _getPhoneState().copyWith(
          countryTitle: _getCountryTitle(),
        ),
      );
    }
    _actionSubject.add(AuthAction.setPhoneNumberMask(mask: _getMask()));
  }

  void _handleChangeCountryTap() {
    _router.toChooseCountry((Country country) {
      _country = country;
      _stateSubject.add(
        _getPhoneState().copyWith(
          countryTitle: _getCountryTitle(),
        ),
      );
      _actionSubject
        ..add(AuthAction.setCountryCode(code: country.code))
        ..add(AuthAction.setPhoneNumberMask(mask: _getMask()));
    });
  }

  void _handleStopVerificationTap() {
    _router.toDialog(
      title: _getString('AppName'),
      body: Body.text(text: _getString('StopVerification')),
      actions: <Action>[
        Action(
          text: _getString('Stop'),
          callback: (IDismissible dismissible) {
            _phoneNumber = null;
            _stateSubject.add(
              AuthState.phoneNumber(
                title: _getString('YourPhone'),
                countryTitle: _getCountryTitle(),
                blockInteraction: false,
              ),
            );
            dismissible.dismiss();
          },
        ),
        Action(
          text: _getString('Continue'),
          callback: (IDismissible dismissible) {
            dismissible.dismiss();
          },
        ),
      ],
    );
  }
}
