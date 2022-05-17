import 'package:coreui/coreui.dart';
import 'package:feature_global_search_impl/feature_global_search_impl.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_interactor.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_result_tile_mapper.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_screen_scope.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_view_model.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_widget_model.dart';
import 'package:feature_global_search_impl/src/screen/global_search/search_interactor_factory.dart';
import 'package:feature_global_search_impl/src/screen/global_search/tile/delegate/delegate.dart';
import 'package:feature_global_search_impl/src/screen/global_search/tile/model/model.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:tile/tile.dart';

@j.module
abstract class GlobalSearchScreenModule {
  @j.singleton
  @j.provides
  static GlobalSearchViewModel provideGlobalSearchViewModel(
    GlobalSearchFeatureDependencies dependencies,
    GlobalSearchInteractor globalSearchInteractor,
  ) =>
      GlobalSearchViewModel(
        router: dependencies.router,
        searchInteractor: globalSearchInteractor,
      );

  @j.singleton
  @j.provides
  static GlobalSearchWidgetModel provideGlobalSearchWidgetModel(
    GlobalSearchViewModel viewModel,
  ) =>
      GlobalSearchWidgetModel(
        viewModel: viewModel,
      );

  @j.provides
  static GlobalSearchInteractor provideGlobalSearchInteractor(
    GlobalSearchFeatureDependencies dependencies,
  ) =>
      GlobalSearchInteractor(
        resultTileMapper: GlobalSearchResultTileMapper(
          chatRepository: dependencies.chatRepository,
        ),
        chatMessageRepository: dependencies.chatMessageRepository,
        chatRepository: dependencies.chatRepository,
        searchInteractorFactory: const SearchInteractorFactory(),
      );

  @j.singleton
  @j.provides
  static IStringsProvider provideStringsProvider(
    GlobalSearchFeatureDependencies dependencies,
  ) =>
      dependencies.stringsProvider;

  @j.singleton
  @j.provides
  static AvatarWidgetFactory provideAvatarWidgetFactory(
    GlobalSearchFeatureDependencies dependencies,
  ) =>
      AvatarWidgetFactory(
        fileRepository: dependencies.fileRepository,
      );

  @j.singleton
  @j.provides
  static TileFactory provideTileFactory(
    AvatarWidgetFactory avatarWidgetFactory,
  ) =>
      TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          ChatResultTileModel: ChatResultTileFactoryDelegate(
            avatarWidgetFactory: avatarWidgetFactory,
            onTap: (BuildContext context, int chatId) {
              GlobalSearchScreenScope.getGlobalSearchWidgetModel(context)
                  .onChatTap(chatId);
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
