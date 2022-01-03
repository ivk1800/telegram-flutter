import 'package:flutter/material.dart';

class NewSecretChatPage extends StatefulWidget {
  const NewSecretChatPage({Key? key}) : super(key: key);

  @override
  State<NewSecretChatPage> createState() => _NewSecretChatPageState();
}

class _NewSecretChatPageState extends State<NewSecretChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('new secret chat'),
      ),
    );
  }
}
