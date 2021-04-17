import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:tdlib/td_api.dart' as td;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  hintText: 'phone',
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    appComponent.getTdClient().send<td.Ok>(
                        td.SetAuthenticationPhoneNumber(
                            phoneNumber: _phoneNumberController.text,
                            settings: td.PhoneNumberAuthenticationSettings(
                                isCurrentPhoneNumber: true,
                                allowFlashCall: false,
                                allowSmsRetrieverApi: false)));
                  },
                  child: const Text('send phone')),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  hintText: 'code',
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    appComponent.getTdClient().send<td.Ok>(
                        td.CheckAuthenticationCode(code: _codeController.text));
                  },
                  child: const Text('send code')),
            ],
          ),
        ));
  }
}
