import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:presentation/src/util/string_provider.dart';

import 'folders_setup_view_model.dart';

class FoldersSetupPage extends StatefulWidget {
  const FoldersSetupPage({Key? key}) : super(key: key);

  @override
  FoldersSetupPageState createState() => FoldersSetupPageState();
}

class FoldersSetupPageState extends State<FoldersSetupPage>
    with StateInjectorMixin<FoldersSetupPage, FoldersSetupPageState> {
  @j.inject
  late IStringsProvider stringsProvider;

  @j.inject
  late ConnectionStateWidgetFactory connectionStateWidgetFactory;

  @j.inject
  late FoldersSetupViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: connectionStateWidgetFactory.create(
            context, (BuildContext context) => Text(stringsProvider.folders)),
      ),
      body: Text(stringsProvider.folders),
    );
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
