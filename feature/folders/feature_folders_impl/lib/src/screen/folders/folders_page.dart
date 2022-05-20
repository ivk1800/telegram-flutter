import 'package:coreui/coreui.dart' as tg;
import 'package:feature_folders_impl/src/screen/folders/folders_screen_scope.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'folders_view_model.dart';

class FoldersPage extends StatefulWidget {
  const FoldersPage({super.key});

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  @override
  Widget build(BuildContext context) {
    final tg.TgAppBarFactory appBarFactory =
        FoldersScreenScope.getTgAppBarFactory(context);
    final IStringsProvider stringsProvider =
        FoldersScreenScope.getStringsProvider(context);
    final FoldersViewModel viewModel =
        FoldersScreenScope.getFoldersViewModel(context);

    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        stringsProvider.filters,
      ),
      body: Column(
        children: <Widget>[
          tg.TextCell(
            onTap: viewModel.onCreateNewFolderTap,
            leading: const Icon(
              Icons.add,
            ),
            title: stringsProvider.createNewFilter,
          ),
        ],
      ),
    );
  }
}
