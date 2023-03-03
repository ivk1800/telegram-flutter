import 'package:coreui/coreui.dart' as tg;
import 'package:feature_logout_impl/src/screen/logout/logout_event.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

import 'logout_view_model.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider = context.read();
    final tg.TgAppBarFactory appBarFactory = context.read();

    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        stringsProvider.logOutTitle,
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider = context.read();
    final LogoutViewModel viewModel = context.read();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        tg.Section(
          text: stringsProvider.alternativeOptions,
        ),
        tg.TextCell(
          onTap: () => viewModel
              .onEvent(const LogoutEvent.tap(TapType.addAnotherAccount)),
          leading: const Icon(Icons.circle),
          title: stringsProvider.addAnotherAccount,
          subtitle: stringsProvider.addAnotherAccountInfo,
        ),
        const tg.Divider(
          indent: tg.DividerIndent.large,
        ),
        tg.TextCell(
          onTap: () =>
              viewModel.onEvent(const LogoutEvent.tap(TapType.setPasscode)),
          leading: const Icon(Icons.circle),
          title: stringsProvider.setPasscode,
          subtitle: stringsProvider.setPasscodeInfo,
        ),
        const tg.Divider(
          indent: tg.DividerIndent.large,
        ),
        tg.TextCell(
          onTap: () =>
              viewModel.onEvent(const LogoutEvent.tap(TapType.clearCache)),
          leading: const Icon(Icons.circle),
          title: stringsProvider.clearCache,
          subtitle: stringsProvider.clearCacheInfo,
        ),
        const tg.Divider(
          indent: tg.DividerIndent.large,
        ),
        tg.TextCell(
          onTap: () => viewModel
              .onEvent(const LogoutEvent.tap(TapType.changePhoneNumber)),
          leading: const Icon(Icons.circle),
          title: stringsProvider.changePhoneNumber,
          subtitle: stringsProvider.changePhoneNumberInfo,
        ),
        const tg.Divider(
          indent: tg.DividerIndent.large,
        ),
        tg.TextCell(
          onTap: () =>
              viewModel.onEvent(const LogoutEvent.tap(TapType.contactSupport)),
          leading: const Icon(Icons.circle),
          title: stringsProvider.contactSupport,
          subtitle: stringsProvider.contactSupportInfo,
        ),
        const tg.SectionDivider(),
        tg.TextCell(
          titleColor: Theme.of(context).colorScheme.error,
          title: stringsProvider.logOutTitle,
          onTap: () => viewModel.onEvent(const LogoutEvent.tap(TapType.logOut)),
        ),
        tg.Annotation(
          text: stringsProvider.logOutInfo,
        ),
      ],
    );
  }
}
