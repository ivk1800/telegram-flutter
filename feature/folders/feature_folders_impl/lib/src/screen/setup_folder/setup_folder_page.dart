import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_impl/src/screen/setup_folder/setup_folder_screen_scope.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

class SetupFolderPage extends StatefulWidget {
  const SetupFolderPage({super.key});

  @override
  State<SetupFolderPage> createState() => _SetupFolderPageState();
}

class _SetupFolderPageState extends State<SetupFolderPage> {
  @override
  Widget build(BuildContext context) {
    final tg.TgAppBarFactory appBarFactory =
        SetupFolderScreenScope.getTgAppBarFactory(context);
    final IStringsProvider stringsProvider =
        SetupFolderScreenScope.getStringsProvider(context);

    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        stringsProvider.filterNew,
      ),
    );
  }
}
