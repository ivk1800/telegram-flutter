library chat_actions_panel;

import 'package:chat_actions_panel/src/panel_state.dart';
import 'package:flutter/widgets.dart';

// todo move implementation to separated module
export 'src/chat_action_pane_interactor.dart';
export 'src/chat_action_panel_factory.dart';
export 'src/panel_state.dart';

abstract class IChatActionPanelFactory {
  Widget create(PanelState state);
}

abstract class IChatActionPanelInteractor {
  Stream<PanelState> get panelStateStream;

  void dispose();
}
