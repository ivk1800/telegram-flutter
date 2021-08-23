import 'package:feature_settings_search_impl/feature_settings_search_impl.dart';
import 'package:feature_settings_search_impl/src/tile/model/faq_result_tile_model.dart';
import 'package:feature_settings_search_impl/src/tile/model/search_result_tile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tile/tile.dart';

import 'search_settings_event.dart';
import 'search_settings_state.dart';

class SearchSettingsBloc
    extends Bloc<SearchSettingsEvent, SearchSettingsState> {
  SearchSettingsBloc({required ISettingsSearchScreenRouter router})
      : _router = router,
        super(const DefaultState(tileModels: <ITileModel>[
          // TODO: implement all https://github.com/DrKLO/Telegram/blob/master/TMessagesProj/src/main/java/org/telegram/ui/ProfileActivity.java#L7701
          SearchResultTileModel(
              type: SearchResultType.NotificationsAndSounds,
              title: 'Notifications and Sounds',
              subtitle: null),
          // TODO: parse faq https://github.com/DrKLO/Telegram/blob/master/TMessagesProj/src/main/java/org/telegram/ui/ProfileActivity.java#L7342
          FaqResultTileModel(
              title: 'FAQ > General',
              subtitle: 'What is Telegram?',
              url: 'https://telegram.org/faq')
        ]));
  final ISettingsSearchScreenRouter _router;

  @override
  Stream<SearchSettingsState> mapEventToState(
      SearchSettingsEvent event) async* {
    if (event is ActionEvent) {
      _handleActionEvent(event);
      return;
    }
  }

  void _handleActionEvent(ActionEvent event) {
    switch (event.runtimeType) {
      case SuggestTap:
        return;
    }
  }
}
