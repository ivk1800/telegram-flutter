import 'package:coreui/coreui.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/bloc/global_search_bloc.dart';
import 'package:feature_global_search_impl/src/screen/global_search/bloc/global_search_event.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_interactor.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_result_tile_mapper.dart';
import 'package:feature_global_search_impl/src/screen/global_search/search_interactor_factory.dart';
import 'package:feature_global_search_impl/src/screen/global_search/tile/delegate/delegate.dart';
import 'package:feature_global_search_impl/src/screen/global_search/tile/model/model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

@j.module
abstract class GlobalSearchScreenModule {
  @j.singleton
  @j.provide
  static GlobalSearchBloc provideGlobalSearchBloc(
          GlobalSearchFeatureDependencies dependencies) =>
      GlobalSearchBloc(
        router: dependencies.router,
        searchInteractor: GlobalSearchInteractor(
          resultTileMapper: GlobalSearchResultTileMapper(
            chatRepository: dependencies.chatRepository,
          ),
          chatMessageRepository: dependencies.chatMessageRepository,
          chatRepository: dependencies.chatRepository,
          searchInteractorFactory: const SearchInteractorFactory(),
        ),
      );

  @j.singleton
  @j.provide
  static ILocalizationManager provideLocalizationManager(
          GlobalSearchFeatureDependencies dependencies) =>
      dependencies.localizationManager;

  @j.singleton
  @j.provide
  static AvatarWidgetFactory provideAvatarWidgetFactory(
          GlobalSearchFeatureDependencies dependencies) =>
      AvatarWidgetFactory(
        fileRepository: dependencies.fileRepository,
      );

  @j.singleton
  @j.provide
  static TileFactory provideTileFactory(
    AvatarWidgetFactory avatarWidgetFactory,
  ) =>
      TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          ChatResultTileModel: ChatResultTileFactoryDelegate(
            avatarWidgetFactory: avatarWidgetFactory,
            onTap: (BuildContext context, int chatId) {
              context.read<GlobalSearchBloc>().add(
                    OnChatTap(
                      chatId: chatId,
                    ),
                  );
            },
          ),
          FileResultTileModel: const FileResultTileFactoryDelegate(),
          LinkResultTileModel: const LinkResultTileFactoryDelegate(),
          MediaResultTileModel: MediaResultTileFactoryDelegate(
            avatarWidgetFactory: avatarWidgetFactory,
          ),
          MusicResultTileModel: const MusicResultTileFactoryDelegate(),
          VoiceResultTileModel: const VoiceResultTileFactoryDelegate(),
        },
      );
}
