import 'package:flutter/material.dart';
import 'package:jext/jext.dart';
import 'package:jugger/jugger.dart' as j;
import 'global_search_view_model.dart';

class GlobalSearchPage extends StatefulWidget {
  const GlobalSearchPage({
    Key? key,
  }) : super(key: key);

  @override
  GlobalSearchPageState createState() => GlobalSearchPageState();
}

class GlobalSearchPageState extends State<GlobalSearchPage>
    with StateInjectorMixin<GlobalSearchPage, GlobalSearchPageState> {
  @j.inject
  late GlobalSearchViewModel viewModel;

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
