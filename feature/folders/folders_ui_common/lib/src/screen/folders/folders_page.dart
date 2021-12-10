import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:folders_presentation/folders_presentation.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({Key? key}) : super(key: key);

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  @override
  Widget build(BuildContext context) {
    final tg.TgAppBarFactory appBarFactory = context.read();
    final ILocalizationManager localizationManager = context.read();
    final FoldersViewModel viewModel = context.read();
    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        localizationManager.getString('Filters'),
      ),
      body: Column(
        children: <Widget>[
          tg.TextCell(
            onTap: viewModel.onCreateNewFolderTap,
            leading: const Icon(
              Icons.add,
            ),
            title: localizationManager.getString('CreateNewFilter'),
          ),
        ],
      ),
    );
  }
}
