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
                decoration: InputDecoration(
                  hintText: 'phone',
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    var d = td.SetAuthenticationPhoneNumber(
                        phoneNumber: _phoneNumberController.text,
                        settings: td.PhoneNumberAuthenticationSettings(
                            isCurrentPhoneNumber: true,
                            allowFlashCall: false,
                            allowSmsRetrieverApi: false));
                    d.extra = 'qwqe';
                    appComponent.getTdClient().clientSend(d);
                  },
                  child: Text('send phone')),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  hintText: 'code',
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    appComponent.getTdClient().clientSend(
                        td.CheckAuthenticationCode(code: _codeController.text));
                  },
                  child: Text('send code')),
            ],
          ),
        ));
  }
}
