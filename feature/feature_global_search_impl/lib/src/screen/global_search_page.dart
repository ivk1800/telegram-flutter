import 'package:flutter/material.dart';

class GlobalSearchPage extends StatelessWidget {
  const GlobalSearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('$index'),
        );
      },
    );
  }
}
