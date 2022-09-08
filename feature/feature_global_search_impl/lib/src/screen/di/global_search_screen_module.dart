import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:coreui/coreui.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_interactor.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_result_tile_mapper.dart';
import 'package:feature_global_search_impl/src/screen/global_search/global_search_widget_model.dart';
import 'package:feature_global_search_impl/src/screen/global_search/search_interactor_factory.dart';
import 'package:feature_global_search_impl/src/screen/global_search/tile/delegate/delegate.dart';
import 'package:feature_global_search_impl/src/screen/global_search/tile/model/model.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:tile/tile.dart';

@j.module
abstract class GlobalSearchScreenModule {
  @j.provides
  static GlobalSearchInteractor provideGlobalSearchInteractor(
    IChatRepository chatRepository,
    IChatMessageRepository chatMessageRepository,
  ) =>
      GlobalSearchInteractor(
        resultTileMapper: GlobalSearchResultTileMapper(
          chatRepository: chatRepository,
        ),
        chatMessageRepository: chatMessageRepository,
        chatRepository: chatRepository,
        searchInteractorFactory: const SearchInteractorFactory(),
      );

  @j.singleton
  @j.provides
  static AvatarWidgetFactory provideAvatarWidgetFactory(
    IFileDownloader fileDownloader,
  ) =>
      AvatarWidgetFactory(fileDownloader: fileDownloader);

  @j.singleton
  @j.provides
  static TileFactory provideTileFactory(
    AvatarWidgetFactory avatarWidgetFactory,
    GlobalSearchWidgetModel globalSearchWidgetModel,
  ) =>
      TileFactory(
        delegates: <Type, ITileFactoryDelegate<ITileModel>>{
          ChatResultTileModel: ChatResultTileFactoryDelegate(
            avatarWidgetFactory: avatarWidgetFactory,
            onTap: (BuildContext context, int chatId) {
              globalSearchWidgetModel.onChatTap(chatId);
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
