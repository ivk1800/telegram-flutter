import 'package:dialog_api/dialog_api.dart';
import 'package:feature_logout_impl/src/logout_feature_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';

import 'logout_event.dart';
import 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc({
    required ILogoutFeatureRouter router,
    required ILocalizationManager localizationManager,
  })  : _router = router,
        _localizationManager = localizationManager,
        super(const LogoutState()) {
    on<Tap>(_onTapEvent);
  }

  final ILogoutFeatureRouter _router;
  final ILocalizationManager _localizationManager;

  void _onTapEvent(Tap tap, Emitter<LogoutState> emit) {
    switch (tap.tap) {
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
          title: _getString('AskAQuestion'),
          body: const Body.text(text: 'AskAQuestionInfo'),
          actions: <Action>[
            Action(
              text: _getString('Cancel'),
              callback: (IDismissible dismissible) {
                dismissible.dismiss();
              },
            ),
            Action(
              text: _getString('AskButton'),
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
          title: _getString('LogOutTitle'),
          body: Body.text(text: _getString('AreYouSureLogout')),
          actions: <Action>[
            Action(
              text: _getString('Cancel'),
              callback: (IDismissible dismissible) {
                dismissible.dismiss();
              },
            ),
            Action(
              type: ActionType.attention,
              text: _getString('LogOutTitle'),
              callback: (IDismissible dismissible) {
                dismissible.dismiss();
              },
            ),
          ],
        );
        break;
    }
  }

  String _getString(String key) => _localizationManager.getString(key);
}
