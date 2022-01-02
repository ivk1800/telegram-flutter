import 'package:feature_sessions_impl/src/screen/sessions/tile/session_tile_factory_delegate.dart';

import 'sessions_view_model.dart';

class SessionTileListener implements ISessionTileListener {
  SessionTileListener({
    required SessionsViewModel viewModel,
  }) : _viewModel = viewModel;

  final SessionsViewModel _viewModel;

  @override
  void onSessionTap(int id) => _viewModel.onSessionTap(id);
}
