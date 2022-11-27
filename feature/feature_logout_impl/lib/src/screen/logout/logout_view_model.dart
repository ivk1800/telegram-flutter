import 'package:core_arch/core_arch.dart';
import 'package:dialog_api/dialog_api.dart';
import 'package:feature_logout_impl/src/logout_feature_router.dart';
import 'package:localization_api/localization_api.dart';

import 'logout_event.dart';

class LogoutViewModel extends BaseViewModel {
  LogoutViewModel({
    required ILogoutFeatureRouter router,
    required IStringsProvider stringsProvider,
  })  : _router = router,
        _stringsProvider = stringsProvider;

  final ILogoutFeatureRouter _router;
  final IStringsProvider _stringsProvider;

  void onEvent(LogoutEvent event) {
    event.when(tap: _onTapEvent);
  }

  void _onTapEvent(TapType tap) {
    switch (tap) {
      case TapType.addAnotherAccount:
        _router.toAddAccount();
        break;
      case TapType.setPasscode:
        _router.toPasscodeSettings();
        break;
      case TapType.clearCache:
        _router.toStorageUsageSettings();
        break;
      case TapType.changePhoneNumber:
        _router.toChangeNumber();
        break;
      case TapType.contactSupport:
        _router.toDialog(
          title: _stringsProvider.askAQuestion,
          body: const Body.text(text: 'AskAQuestionInfo'),
          actions: <Action>[
            Action(
              text: _stringsProvider.cancel,
              callback: (IDismissible dismissible) {
                dismissible.dismiss();
              },
            ),
            Action(
              text: _stringsProvider.askButton,
              callback: (IDismissible dismissible) {
                _router.toChat(0);
                dismissible.dismiss();
              },
            ),
          ],
        );
        break;
      case TapType.logOut:
        _router.toDialog(
          title: _stringsProvider.logOutTitle,
          body: Body.text(text: _stringsProvider.areYouSureLogout),
          actions: <Action>[
            Action(
              text: _stringsProvider.cancel,
              callback: (IDismissible dismissible) {
                dismissible.dismiss();
              },
            ),
            Action(
              type: ActionType.attention,
              text: _stringsProvider.logOutTitle,
              callback: (IDismissible dismissible) {
                dismissible.dismiss();
              },
            ),
          ],
        );
        break;
    }
  }
}
