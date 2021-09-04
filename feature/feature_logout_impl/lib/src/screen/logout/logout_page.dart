import 'package:coreui/coreui.dart' as tg;
import 'package:feature_logout_impl/src/screen/logout/bloc/logout_bloc.dart';
import 'package:feature_logout_impl/src/screen/logout/bloc/logout_event.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();
    final tg.TgAppBarFactory appBarFactory = context.read();

    return Scaffold(
      appBar: appBarFactory.createDefaultTitle(
        context,
        localizationManager.getString('LogOutTitle'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();
    final LogoutBloc bloc = context.read();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        tg.Section(
          text: localizationManager.getString('AlternativeOptions'),
        ),
        tg.TextCell(
          onTap: () {
            bloc.add(const TapEvent(TapType.AddAnotherAccount));
          },
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('AddAnotherAccount'),
          subtitle: localizationManager.getString('AddAnotherAccountInfo'),
        ),
        const tg.Divider(
          indent: tg.DividerIndent.Large,
        ),
        tg.TextCell(
          onTap: () {
            bloc.add(const TapEvent(TapType.SetPasscode));
          },
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('SetPasscode'),
          subtitle: localizationManager.getString('SetPasscodeInfo'),
        ),
        const tg.Divider(
          indent: tg.DividerIndent.Large,
        ),
        tg.TextCell(
          onTap: () {
            bloc.add(const TapEvent(TapType.ClearCache));
          },
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('ClearCache'),
          subtitle: localizationManager.getString('ClearCacheInfo'),
        ),
        const tg.Divider(
          indent: tg.DividerIndent.Large,
        ),
        tg.TextCell(
          onTap: () {
            bloc.add(const TapEvent(TapType.ChangePhoneNumber));
          },
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('ChangePhoneNumber'),
          subtitle: localizationManager.getString('ChangePhoneNumberInfo'),
        ),
        const tg.Divider(
          indent: tg.DividerIndent.Large,
        ),
        tg.TextCell(
          onTap: () {
            bloc.add(const TapEvent(TapType.ContactSupport));
          },
          leading: const Icon(Icons.circle),
          title: localizationManager.getString('ContactSupport'),
          subtitle: localizationManager.getString('ContactSupportInfo'),
        ),
        const tg.SectionDivider(),
        tg.TextCell(
          titleColor: Theme.of(context).errorColor,
          title: localizationManager.getString('LogOutTitle'),
          onTap: () {
            bloc.add(const TapEvent(TapType.LogOut));
          },
        ),
        tg.Annotation(
          text: localizationManager.getString('LogOutInfo'),
        ),
      ],
    );
  }
}
