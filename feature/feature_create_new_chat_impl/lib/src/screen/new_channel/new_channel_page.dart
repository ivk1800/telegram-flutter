import 'package:flutter/material.dart';

class NewChannelPage extends StatefulWidget {
  const NewChannelPage({Key? key}) : super(key: key);

  @override
  State<NewChannelPage> createState() => _NewChannelPageState();
}

class _NewChannelPageState extends State<NewChannelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('new channel'),
      ),
    );
  }
}
