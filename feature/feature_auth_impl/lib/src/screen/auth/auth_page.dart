import 'dart:async';

import 'package:feature_auth_impl/src/screen/auth/bloc/auth_action.dart';
import 'package:feature_auth_impl/src/screen/auth/bloc/auth_bloc.dart';
import 'package:feature_auth_impl/src/screen/auth/bloc/auth_event.dart';
import 'package:feature_auth_impl/src/screen/auth/bloc/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
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

  @override
  void initState() {
    final AuthBloc bloc = context.read<AuthBloc>();
    _countryCodeController.addListener(() {
      bloc.add(CountryCodeChanged(
        code: _countryCodeController.text,
      ));
    });
    _codeCell5Controller.addListener(() {
      final String code5 = _codeCell5Controller.text;
      if (code5.isNotEmpty) {
        final String code1 = _codeCell1Controller.text;
        final String code2 = _codeCell2Controller.text;
        final String code3 = _codeCell3Controller.text;
        final String code4 = _codeCell4Controller.text;
        bloc.add(
          SubmitCodeTap(
            code: '$code1$code2$code3$code4$code5',
          ),
        );
      }
    });

    _actionsSubscription = bloc.actions.listen(_handleAction);
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {},
      builder: (BuildContext context, AuthState state) => Scaffold(
        appBar: _buildAppBar(state),
        floatingActionButton: _buildFloatingActionButton(state, context),
        body: _buildBody(state, context),
      ).withBlockInteraction(state.blockInteraction),
    );
  }

  void _handleAction(AuthAction event) {
    switch (event.runtimeType) {
      case SetCountryCode:
        {
          _countryCodeController.value = _countryCodeController.value.copyWith(
            text: (event as SetCountryCode).code.toString(),
          );
          _phoneNumberFocusNode.requestFocus();
          break;
        }
      case SetPhoneNumberMask:
        {
          _phoneMaskFormatter.updateMask(
            mask: (event as SetPhoneNumberMask).mask,
          );
          break;
        }
      case ResetCode:
        {
          _codeCell1Controller.value = TextEditingValue.empty;
          _codeCell2Controller.value = TextEditingValue.empty;
          _codeCell3Controller.value = TextEditingValue.empty;
          _codeCell4Controller.value = TextEditingValue.empty;
          _codeCell5Controller.value = TextEditingValue.empty;
          _code1FocusNode.requestFocus();
          break;
        }
    }
  }

  PreferredSizeWidget _buildAppBar(AuthState state) {
    return AppBar(
      leading: state is PhoneNumberState
          ? null
          : IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                context.read<AuthBloc>().add(const StopVerificationTap());
              },
            ),
      automaticallyImplyLeading: false,
      title: Text(state.title),
    );
  }

  Widget _buildFloatingActionButton(AuthState state, BuildContext context) {
    return Visibility(
      visible: state is PhoneNumberState,
      child: FloatingActionButton(
        child: const Icon(Icons.arrow_forward_outlined),
        onPressed: () {
          context.read<AuthBloc>().add(
                SubmitPhoneTap(
                  number:
                      '${_countryCodeController.text}${_phoneMaskFormatter.getUnmaskedText()}',
                ),
              );
        },
      ),
    );
  }

  Widget _buildBody(AuthState state, BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          child: child,
          opacity: animation,
        );
      },
      child: state is PhoneNumberState
          ? _buildPhoneNumberState(state)
          : _buildCodeState(context, state as CodeState),
    );
  }

  Widget _buildCodeState(
    BuildContext context,
    CodeState state,
  ) {
    final ILocalizationManager localizationManager = context.read();
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
            _buildCodeCell(
              focusNode: _code1FocusNode,
              controller: _codeCell1Controller,
            ),
            const SizedBox(
              width: 8,
            ),
            _buildCodeCell(
              controller: _codeCell2Controller,
            ),
            const SizedBox(
              width: 8,
            ),
            _buildCodeCell(
              controller: _codeCell3Controller,
            ),
            const SizedBox(
              width: 8,
            ),
            _buildCodeCell(
              controller: _codeCell4Controller,
            ),
            const SizedBox(
              width: 8,
            ),
            _buildCodeCell(
              controller: _codeCell5Controller,
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
            style: TextStyle(color: theme.accentColor),
          ),
        ),
      ],
    );
  }

  Widget _buildCodeCell({
    FocusNode? focusNode,
    required TextEditingController controller,
    bool focusNext = true,
  }) {
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

  Widget _buildPhoneNumberState(PhoneNumberState state) {
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
          onPressed: () {
            context.read<AuthBloc>().add(const ChangeCountryTap());
          },
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: calculatedCodeWidth.width,
                child: TextField(
                  controller: _countryCodeController,
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
                  focusNode: _phoneNumberFocusNode,
                  inputFormatters: <TextInputFormatter>[_phoneMaskFormatter],
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: _phoneMaskFormatter.getMask(),
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
