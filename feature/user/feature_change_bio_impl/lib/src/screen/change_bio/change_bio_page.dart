import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'change_bio_screen_scope.dart';

class ChangeBioPage extends StatelessWidget {
  const ChangeBioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        ChangeBioScreenScope.getStringsProvider(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(stringsProvider.userBio),
      ),
    );
  }
}
