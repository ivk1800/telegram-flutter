import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class SetupFolderPage extends StatefulWidget {
  const SetupFolderPage({super.key});

  @override
  State<SetupFolderPage> createState() => _SetupFolderPageState();
}

class _SetupFolderPageState extends State<SetupFolderPage> {
  @override
  Widget build(BuildContext context) {
    final tg.TgAppBarFactory appBarFactory = context.read();
    final ILocalizationManager localizationManager = context.read();
    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        localizationManager.getString('FilterNew'),
      ),
    );
  }
}
