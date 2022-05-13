import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_change_username_impl/src/screen/change_username/change_username_screen_widget_model.dart';
import 'package:feature_change_username_impl/src/screen/change_username/change_username_state.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'change_username_screen_scope.dart';

class ChangeUsernamePage extends StatelessWidget {
  const ChangeUsernamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final ChangeUsernameScreenWidgetModel widgetModel =
        ChangeUsernameScreenScope.getChangeUsernameScreenWidgetModel(context);

    return StreamListener<CheckUsernameState>(
      stream: widgetModel.state,
      builder: (BuildContext context, CheckUsernameState state) {
        return state.map(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          data: (CheckUsernameStateData state) {
            return _BodyContent(state: state);
          },
        );
      },
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent({required this.state});

  final CheckUsernameStateData state;

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        ChangeUsernameScreenScope.getStringsProvider(context);
    final ChangeUsernameScreenWidgetModel widgetModel =
        ChangeUsernameScreenScope.getChangeUsernameScreenWidgetModel(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          autofocus: true,
          controller: widgetModel.usernameController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: stringsProvider.usernamePlaceholder,
          ),
        ),
        Text(stringsProvider.usernameHelp),
        const SizedBox(height: 16),
        Text(stringsProvider.usernameHelpLink(<dynamic>['placeholder']))
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        ChangeUsernameScreenScope.getStringsProvider(context);
    final tg.TgAppBarFactory appBarFactory =
        ChangeUsernameScreenScope.getTgAppBarFactory(context);

    final ChangeUsernameScreenWidgetModel widgetModel =
        ChangeUsernameScreenScope.getChangeUsernameScreenWidgetModel(context);

    return StreamListener<CheckUsernameState>(
      stream: widgetModel.state,
      builder: (BuildContext context, CheckUsernameState state) {
        final List<Widget> actions;

        if (state is CheckUsernameStateLoading) {
          actions = const <Widget>[];
        } else {
          actions = <Widget>[
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: widgetModel.onSaveTap,
            ),
          ];
        }

        return appBarFactory.createDefaultTitle(
          context,
          stringsProvider.username,
          actions: actions,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
