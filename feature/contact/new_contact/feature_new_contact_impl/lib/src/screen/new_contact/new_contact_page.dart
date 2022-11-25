import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_state.dart';
import 'package:feature_new_contact_impl/src/screen/new_contact/new_contact_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'new_contact_screen_scope_delegate.scope.dart';
import 'new_contact_widget_model.dart';

class NewContactPage extends StatelessWidget {
  const NewContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: _Body(),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        NewContactScreenScope.getStringsProvider(context);
    final NewContactWidgetModel newContactWidgetModel =
        NewContactScreenScope.getNewContactWidgetModel(context);

    return AppBar(
      title: Text(stringsProvider.newContact),
      actions: <Widget>[
        IconButton(
          constraints: const BoxConstraints.expand(width: 80),
          icon: Text(stringsProvider.done.toUpperCase()),
          onPressed: newContactWidgetModel.onDoneTap,
        ),
        // TextButton(onPressed: () {}, child: Text(stringsProvider.done))
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    NewContactScreenScope.getNewContactViewModel(context);

    final IStringsProvider stringsProvider =
        NewContactScreenScope.getStringsProvider(context);
    final NewContactWidgetModel newContactWidgetModel =
        NewContactScreenScope.getNewContactWidgetModel(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const _UserInfo(),
        const SizedBox(height: 16),
        TextField(
          autofocus: true,
          controller: newContactWidgetModel.firstNameController,
          decoration: InputDecoration(
            hintText: stringsProvider.firstName,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: newContactWidgetModel.lastNameController,
          decoration: InputDecoration(
            hintText: stringsProvider.lastName,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          stringsProvider.mobileHiddenExceptionInfo(<dynamic>['args']),
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            ValueListenableBuilder<bool>(
              valueListenable: newContactWidgetModel.shareMyPhone,
              builder: (BuildContext context, bool value, Widget? child) {
                return Checkbox(
                  value: value,
                  onChanged: (bool? value) {
                    newContactWidgetModel.shareMyPhone.value = value!;
                  },
                );
              },
            ),
            Flexible(
              child:
                  Text(stringsProvider.sharePhoneNumberWith(<dynamic>['args'])),
            )
          ],
        )
      ],
    );
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo();

  @override
  Widget build(BuildContext context) {
    final NewContactWidgetModel newContactWidgetModel =
        NewContactScreenScope.getNewContactWidgetModel(context);

    return StreamListener<NewContactState>(
      stream: newContactWidgetModel.state,
      builder: (BuildContext context, NewContactState state) {
        return state.map(
          loading: (_) {
            return const Center(child: CircularProgressIndicator());
          },
          data: (DataState dataState) {
            final UserInformation information = dataState.userInformation;
            return Row(
              children: <Widget>[
                AvatarWidget(
                  factory:
                      NewContactScreenScope.getAvatarWidgetFactory(context),
                  avatar: information.avatar,
                  radius: 32,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        information.phoneNumber,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        information.onlineStatus,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        information.phoneNumber,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        information.onlineStatus,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
