import 'dart:async';

import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization_api/localization_api.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'view_model/auth_action.dart';
import 'view_model/auth_state.dart';
import 'view_model/auth_view_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthContext {
  _AuthContext({
    required this.countryCodeController,
    required this.phoneNumberFocusNode,
    required this.phoneMaskFormatter,
    required this.phoneNumberController,
    required this.code1FocusNode,
    required this.codeCell1Controller,
    required this.codeCell2Controller,
    required this.codeCell3Controller,
    required this.codeCell4Controller,
    required this.codeCell5Controller,
  });

  final TextEditingController countryCodeController;
  final FocusNode phoneNumberFocusNode;
  final MaskTextInputFormatter phoneMaskFormatter;

  final TextEditingController phoneNumberController;
  final FocusNode code1FocusNode;
  final TextEditingController codeCell1Controller;
  final TextEditingController codeCell2Controller;
  final TextEditingController codeCell3Controller;
  final TextEditingController codeCell4Controller;

  final TextEditingController codeCell5Controller;
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _countryCodeController = TextEditingController();
  final MaskTextInputFormatter _phoneMaskFormatter = MaskTextInputFormatter();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeCell1Controller = TextEditingController();
  final TextEditingController _codeCell2Controller = TextEditingController();
  final TextEditingController _codeCell3Controller = TextEditingController();
  final TextEditingController _codeCell4Controller = TextEditingController();
  final TextEditingController _codeCell5Controller = TextEditingController();

  StreamSubscription<AuthAction>? _actionsSubscription;

  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _code1FocusNode = FocusNode();

  late final _AuthContext _authContext = _AuthContext(
    code1FocusNode: _code1FocusNode,
    codeCell1Controller: _codeCell1Controller,
    codeCell2Controller: _codeCell2Controller,
    codeCell3Controller: _codeCell3Controller,
    codeCell4Controller: _codeCell4Controller,
    codeCell5Controller: _codeCell5Controller,
    countryCodeController: _countryCodeController,
    phoneMaskFormatter: _phoneMaskFormatter,
    phoneNumberController: _phoneNumberController,
    phoneNumberFocusNode: _phoneNumberFocusNode,
  );

  @override
  void initState() {
    final AuthViewModel viewModel = context.read<AuthViewModel>();
    _countryCodeController.addListener(() {
      viewModel.onCountryCodeChanged(_countryCodeController.text);
    });
    _codeCell5Controller.addListener(() {
      final String code5 = _codeCell5Controller.text;
      if (code5.isNotEmpty) {
        final String code1 = _codeCell1Controller.text;
        final String code2 = _codeCell2Controller.text;
        final String code3 = _codeCell3Controller.text;
        final String code4 = _codeCell4Controller.text;
        viewModel.onSubmitCodeTap('$code1$code2$code3$code4$code5');
      }
    });

    _actionsSubscription = viewModel.actions.listen(_handleAction);
    super.initState();
  }

  @override
  void dispose() {
    _countryCodeController.dispose();
    _phoneNumberController.dispose();
    _codeCell1Controller.dispose();
    _codeCell2Controller.dispose();
    _codeCell3Controller.dispose();
    _codeCell4Controller.dispose();
    _codeCell5Controller.dispose();
    _actionsSubscription?.cancel();
    _code1FocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthViewModel viewModel = context.read<AuthViewModel>();
    return StreamListener<AuthState>(
      stream: viewModel.state,
      builder: (_, AuthState state) {
        return tg.BlockInteraction(
          block: state.blockInteraction,
          child: Provider<_AuthContext>(
            create: (_) => _authContext,
            child: _AuthScaffold(state: state),
          ),
        );
      },
    );
  }

  void _handleAction(AuthAction event) {
    event.when(
      setCountryCode: (int code) {
        _countryCodeController.value = _countryCodeController.value.copyWith(
          text: code.toString(),
        );
        _phoneNumberFocusNode.requestFocus();
      },
      setPhoneNumberMask: (String mask) {
        _phoneMaskFormatter.updateMask(
          mask: mask,
        );
      },
      resetCode: () {
        _codeCell1Controller.value = TextEditingValue.empty;
        _codeCell2Controller.value = TextEditingValue.empty;
        _codeCell3Controller.value = TextEditingValue.empty;
        _codeCell4Controller.value = TextEditingValue.empty;
        _codeCell5Controller.value = TextEditingValue.empty;
        _code1FocusNode.requestFocus();
      },
    );
  }
}

class _CodeCell extends StatelessWidget {
  const _CodeCell({
    Key? key,
    required this.controller,
    this.focusNode,
    this.focusNext = true,
  }) : super(key: key);

  final FocusNode? focusNode;
  final TextEditingController controller;
  final bool focusNext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        onChanged: (String value) {
          if (focusNext && value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }
}

class _AuthScaffold extends StatelessWidget {
  const _AuthScaffold({
    Key? key,
    required this.state,
  }) : super(key: key);

  final AuthState state;

  @override
  Widget build(BuildContext context) {
    final AuthState state = this.state;

    return Scaffold(
        appBar: _AppBar(state: state),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: state.map(
            phoneNumber: (PhoneNumberState value) =>
                _PhoneNumberStateWidget(state: value),
            code: (CodeState value) => CodeStateWidget(
              state: value,
            ),
          ),
        ),
        floatingActionButton: state.maybeMap(
          phoneNumber: (_) => const _SubmitPhone(),
          orElse: () => null,
        ));
  }
}

class _PhoneNumberStateWidget extends StatelessWidget {
  const _PhoneNumberStateWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final PhoneNumberState state;

  @override
  Widget build(BuildContext context) {
    final _AuthContext authContext = context.read();
    final ILocalizationManager localizationManager = context.read();
    final Size calculatedCodeWidth = (TextPainter(
      text: const TextSpan(text: '+00000'),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout())
        .size;

    return Column(
      key: const ValueKey<dynamic>('phone'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MaterialButton(
          child: Text(state.countryTitle),
          onPressed: () => context.read<AuthViewModel>().onChangeCountryTap(),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: calculatedCodeWidth.width,
                child: TextField(
                  controller: authContext.countryCodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(4),
                  ],
                  decoration: const InputDecoration(prefix: Text('+')),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextField(
                  focusNode: authContext.phoneNumberFocusNode,
                  inputFormatters: <TextInputFormatter>[
                    authContext.phoneMaskFormatter
                  ],
                  controller: authContext.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: authContext.phoneMaskFormatter.getMask(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
          child: Text(localizationManager.getString('StartText')),
        ),
      ],
    );
  }
}

class CodeStateWidget extends StatelessWidget {
  const CodeStateWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  final CodeState state;

  @override
  Widget build(BuildContext context) {
    final _AuthContext authContext = context.read();
    final ILocalizationManager localizationManager = context.read();
    final ThemeData theme = Theme.of(context);
    return Column(
      key: const ValueKey<dynamic>('code'),
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        const FlutterLogo(
          size: 100,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          localizationManager.getString('SentAppCodeTitle'),
          style: theme.textTheme.bodyText1!.copyWith(
            fontSize: 17,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            localizationManager.getString('SentAppCode'),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _CodeCell(
              focusNode: authContext.code1FocusNode,
              controller: authContext.codeCell1Controller,
            ),
            const SizedBox(
              width: 8,
            ),
            _CodeCell(
              controller: authContext.codeCell2Controller,
            ),
            const SizedBox(
              width: 8,
            ),
            _CodeCell(
              controller: authContext.codeCell3Controller,
            ),
            const SizedBox(
              width: 8,
            ),
            _CodeCell(
              controller: authContext.codeCell4Controller,
            ),
            const SizedBox(
              width: 8,
            ),
            _CodeCell(
              controller: authContext.codeCell5Controller,
              focusNext: false,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        MaterialButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('not implemented'),
              ),
            );
          },
          child: Text(
            localizationManager.getString('DidNotGetTheCodeSms'),
            style: TextStyle(color: theme.colorScheme.secondary),
          ),
        ),
      ],
    );
  }
}

class _SubmitPhone extends StatelessWidget {
  const _SubmitPhone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _AuthContext authContext = context.read();
    return FloatingActionButton(
      child: const Icon(Icons.arrow_forward_outlined),
      onPressed: () {
        context.read<AuthViewModel>().onSubmitPhoneTap(
              '${authContext.countryCodeController.text}${authContext.phoneMaskFormatter.getUnmaskedText()}',
            );
      },
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.state,
  }) : super(key: key);

  final AuthState state;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: state is PhoneNumberState
          ? null
          : IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () =>
                  context.read<AuthViewModel>().onStopVerificationTap(),
            ),
      // todo: override ModelRoute in splitview
      automaticallyImplyLeading: false,
      title: Text(state.title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
