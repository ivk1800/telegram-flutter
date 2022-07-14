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
    final ILocalizationManager localizationManager = context.read();
    final tg.TgAppBarFactory appBarFactory = context.read();

    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        localizationManager.getString('LogOutTitle'),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();
    final LogoutViewModel viewModel = context.read();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        tg.Section(
          text: localizationManager.getString('AlternativeOptions'),
        ),
        tg.TextCell(
          onTap: () => viewModel
              .onEvent(const LogoutEvent.tap(TapType.addAnotherAccount)),
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('AddAnotherAccount'),
          subtitle: localizationManager.getString('AddAnotherAccountInfo'),
        ),
        const tg.Divider(
          indent: tg.DividerIndent.large,
        ),
        tg.TextCell(
          onTap: () =>
              viewModel.onEvent(const LogoutEvent.tap(TapType.setPasscode)),
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('SetPasscode'),
          subtitle: localizationManager.getString('SetPasscodeInfo'),
        ),
        const tg.Divider(
          indent: tg.DividerIndent.large,
        ),
        tg.TextCell(
          onTap: () =>
              viewModel.onEvent(const LogoutEvent.tap(TapType.clearCache)),
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('ClearCache'),
          subtitle: localizationManager.getString('ClearCacheInfo'),
        ),
        const tg.Divider(
          indent: tg.DividerIndent.large,
        ),
        tg.TextCell(
          onTap: () => viewModel
              .onEvent(const LogoutEvent.tap(TapType.changePhoneNumber)),
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('ChangePhoneNumber'),
          subtitle: localizationManager.getString('ChangePhoneNumberInfo'),
        ),
        const tg.Divider(
          indent: tg.DividerIndent.large,
        ),
        tg.TextCell(
          onTap: () =>
              viewModel.onEvent(const LogoutEvent.tap(TapType.contactSupport)),
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('ContactSupport'),
          subtitle: localizationManager.getString('ContactSupportInfo'),
        ),
        const tg.SectionDivider(),
        tg.TextCell(
          titleColor: Theme.of(context).errorColor,
          title: localizationManager.getString('LogOutTitle'),
          onTap: () => viewModel.onEvent(const LogoutEvent.tap(TapType.logOut)),
        ),
        tg.Annotation(
          text: localizationManager.getString('LogOutInfo'),
        ),
      ],
    );
  }
}
