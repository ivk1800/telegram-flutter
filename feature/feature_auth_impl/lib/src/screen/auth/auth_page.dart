import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_auth_impl/src/screen/auth/auth_screen_scope_delegate.scope.dart';
import 'package:feature_auth_impl/src/screen/auth/auth_screen_widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization_api/localization_api.dart';

import 'view_model/auth_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthScreenWidgetModel widgetModel =
        AuthScreenScope.getAuthScreenWidgetModel(context);
    return StreamListener<AuthState>(
      stream: widgetModel.state,
      builder: (_, AuthState state) {
        return tg.BlockInteraction(
          block: state.blockInteraction,
          child: _AuthScaffold(state: state),
        );
      },
    );
  }
}

class _CodeCell extends StatelessWidget {
  const _CodeCell({
    required this.controller,
    this.focusNode,
    this.focusNext = true,
    this.autofocus = false,
  });

  final FocusNode? focusNode;
  final TextEditingController controller;
  final bool focusNext;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        autofocus: autofocus,
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
    required this.state,
  });

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
          code: (CodeState value) => _CodeStateWidget(
            state: value,
          ),
        ),
      ),
      floatingActionButton: state.maybeMap(
        phoneNumber: (_) => const _SubmitPhone(),
        orElse: () => null,
      ),
    );
  }
}

class _PhoneNumberStateWidget extends StatelessWidget {
  const _PhoneNumberStateWidget({
    required this.state,
  });

  final PhoneNumberState state;

  @override
  Widget build(BuildContext context) {
    final AuthScreenWidgetModel widgetModel =
        AuthScreenScope.getAuthScreenWidgetModel(context);
    final IStringsProvider stringsProvider =
        AuthScreenScope.getStringsProvider(context);
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
          onPressed: widgetModel.onChangeCountryTap,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: calculatedCodeWidth.width,
                child: TextField(
                  autofocus: true,
                  controller: widgetModel.countryCodeController,
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
                  focusNode: widgetModel.phoneNumberFocusNode,
                  inputFormatters: <TextInputFormatter>[
                    widgetModel.phoneMaskFormatter
                  ],
                  controller: widgetModel.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: widgetModel.phoneMaskFormatter.getMask(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
          child: Text(stringsProvider.startText),
        ),
      ],
    );
  }
}

class _CodeStateWidget extends StatelessWidget {
  const _CodeStateWidget({required this.state});

  final CodeState state;

  @override
  Widget build(BuildContext context) {
    final AuthScreenWidgetModel widgetModel =
        AuthScreenScope.getAuthScreenWidgetModel(context);
    final IStringsProvider stringsProvider =
        AuthScreenScope.getStringsProvider(context);
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
          stringsProvider.sentAppCodeTitle,
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
            stringsProvider.sentAppCode,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _CodeCell(
              focusNode: widgetModel.code1FocusNode,
              autofocus: true,
              controller: widgetModel.codeCell1Controller,
            ),
            const SizedBox(width: 8),
            _CodeCell(controller: widgetModel.codeCell2Controller),
            const SizedBox(width: 8),
            _CodeCell(
              controller: widgetModel.codeCell3Controller,
            ),
            const SizedBox(width: 8),
            _CodeCell(controller: widgetModel.codeCell4Controller),
            const SizedBox(width: 8),
            _CodeCell(
              controller: widgetModel.codeCell5Controller,
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
            stringsProvider.didNotGetTheCodeSms,
            style: TextStyle(color: theme.colorScheme.secondary),
          ),
        ),
      ],
    );
  }
}

class _SubmitPhone extends StatelessWidget {
  const _SubmitPhone();

  @override
  Widget build(BuildContext context) {
    final AuthScreenWidgetModel widgetModel =
        AuthScreenScope.getAuthScreenWidgetModel(context);
    return FloatingActionButton(
      child: const Icon(Icons.arrow_forward_outlined),
      onPressed: widgetModel.onSubmitPhoneTap,
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.state,
  });

  final AuthState state;

  @override
  Widget build(BuildContext context) {
    final AuthScreenWidgetModel widgetModel =
        AuthScreenScope.getAuthScreenWidgetModel(context);
    return AppBar(
      leading: state is PhoneNumberState
          ? null
          : IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: widgetModel.onStopVerificationTap,
            ),
      // todo: override ModelRoute in splitview
      automaticallyImplyLeading: false,
      title: Text(state.title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
