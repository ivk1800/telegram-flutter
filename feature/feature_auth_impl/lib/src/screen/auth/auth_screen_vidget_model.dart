import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'view_model/auth_action.dart';
import 'view_model/auth_state.dart';
import 'view_model/auth_view_model.dart';

@j.singleton
class AuthScreenWidgetModel {
  @j.inject
  AuthScreenWidgetModel({
    required AuthViewModel viewModel,
  }) : _viewModel = viewModel {
    countryCodeController.addListener(onCountryCodeChanged);
    codeCell5Controller.addListener(onCodeCell5CodeChanged);
    _actionsSubscription = viewModel.actions.listen(_handleAction);
  }

  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode code1FocusNode = FocusNode();

  final TextEditingController countryCodeController = TextEditingController();
  final MaskTextInputFormatter phoneMaskFormatter = MaskTextInputFormatter();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController codeCell1Controller = TextEditingController();
  final TextEditingController codeCell2Controller = TextEditingController();
  final TextEditingController codeCell3Controller = TextEditingController();
  final TextEditingController codeCell4Controller = TextEditingController();
  final TextEditingController codeCell5Controller = TextEditingController();

  final AuthViewModel _viewModel;

  StreamSubscription<AuthAction>? _actionsSubscription;

  Stream<AuthState> get state => _viewModel.state;

  void dispose() {
    _actionsSubscription?.cancel();

    countryCodeController.removeListener(onCountryCodeChanged);
    codeCell5Controller.removeListener(onCodeCell5CodeChanged);

    countryCodeController.dispose();
    phoneNumberController.dispose();
    codeCell1Controller.dispose();
    codeCell2Controller.dispose();
    codeCell3Controller.dispose();
    codeCell4Controller.dispose();
    codeCell5Controller.dispose();

    code1FocusNode.dispose();
    phoneNumberFocusNode.dispose();
  }

  void onCountryCodeChanged() {
    _viewModel.onCountryCodeChanged(countryCodeController.text);
  }

  void onCodeCell5CodeChanged() {
    final String code5 = codeCell5Controller.text;
    if (code5.isNotEmpty) {
      final String code1 = codeCell1Controller.text;
      final String code2 = codeCell2Controller.text;
      final String code3 = codeCell3Controller.text;
      final String code4 = codeCell4Controller.text;
      _viewModel.onSubmitCodeTap('$code1$code2$code3$code4$code5');
    }
  }

  void onSubmitPhoneTap() {
    _viewModel.onSubmitPhoneTap(
      '${countryCodeController.text}${phoneMaskFormatter.getUnmaskedText()}',
    );
  }

  void onChangeCountryTap() {
    _viewModel.onChangeCountryTap();
  }

  void onStopVerificationTap() {
    _viewModel.onStopVerificationTap();
  }

  void _handleAction(AuthAction event) {
    event.when(
      setCountryCode: (int code) {
        countryCodeController.value = countryCodeController.value.copyWith(
          text: code.toString(),
        );
        phoneNumberFocusNode.requestFocus();
      },
      setPhoneNumberMask: (String mask) {
        phoneMaskFormatter.updateMask(
          mask: mask,
        );
      },
      resetCode: () {
        codeCell1Controller.value = TextEditingValue.empty;
        codeCell2Controller.value = TextEditingValue.empty;
        codeCell3Controller.value = TextEditingValue.empty;
        codeCell4Controller.value = TextEditingValue.empty;
        codeCell5Controller.value = TextEditingValue.empty;
        code1FocusNode.requestFocus();
      },
    );
  }
}
