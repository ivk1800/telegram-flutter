import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search_component/search_component.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tile/tile.dart';

import 'bloc/global_search_state.dart';
import 'bloc/search_page_state.dart';
import 'global_search_result_category.dart';
import 'global_search_result_tile_mapper.dart';
import 'search_interactor_factory.dart';

// todo: implement pagination
class GlobalSearchInteractor {
  GlobalSearchInteractor({
    required SearchInteractorFactory searchInteractorFactory,
    required IChatRepository chatRepository,
    required GlobalSearchResultTileMapper resultTileMapper,
    required IChatMessageRepository chatMessageRepository,
  })  : _searchInteractorFactory = searchInteractorFactory,
        _resultTileMapper = resultTileMapper,
        _chatMessageRepository = chatMessageRepository,
        _chatRepository = chatRepository {
    _cache[GlobalSearchResultCategory.chats] = _createChatsSearchInteractor();

    _cache[GlobalSearchResultCategory.media] = _createMessagesSearchInteractor(
      filter: const td.SearchMessagesFilterPhotoAndVideo(),
      mapper: _resultTileMapper.mapToMediaTileModel,
    );
    _cache[GlobalSearchResultCategory.links] = _createMessagesSearchInteractor(
      filter: const td.SearchMessagesFilterUrl(),
      mapper: _resultTileMapper.mapToLinkTileModel,
    );
    _cache[GlobalSearchResultCategory.files] = _createMessagesSearchInteractor(
      filter: const td.SearchMessagesFilterDocument(),
      mapper: _resultTileMapper.mapToFileTileModel,
    );
    _cache[GlobalSearchResultCategory.music] = _createMessagesSearchInteractor(
      filter: const td.SearchMessagesFilterAudio(),
      mapper: _resultTileMapper.mapToMusicTileModel,
    );
    _cache[GlobalSearchResultCategory.voice] = _createMessagesSearchInteractor(
      filter: const td.SearchMessagesFilterVoiceNote(),
      mapper: _resultTileMapper.mapToVoiceTileModel,
    );

    Rx.combineLatest6<PageState, PageState, PageState, PageState, PageState,
        PageState, GlobalSearchState>(
      _cache[GlobalSearchResultCategory.chats]!.result.map(_mapToPageState),
      _cache[GlobalSearchResultCategory.media]!.result.map(_mapToPageState),
      _cache[GlobalSearchResultCategory.links]!.result.map(_mapToPageState),
      _cache[GlobalSearchResultCategory.files]!.result.map(_mapToPageState),
      _cache[GlobalSearchResultCategory.music]!.result.map(_mapToPageState),
      _cache[GlobalSearchResultCategory.voice]!.result.map(_mapToPageState),
      (
        PageState chats,
        PageState media,
        PageState links,
        PageState files,
        PageState music,
        PageState voice,
      ) =>
          GlobalSearchState(
        chatsPageState: chats,
        filesPageState: files,
        linksPageState: links,
        mediaPageState: media,
        musicPageState: music,
        voicePageState: voice,
      ),
    ).listen(_stateSubject.add);
  }

  final SearchInteractorFactory _searchInteractorFactory;
  final GlobalSearchResultTileMapper _resultTileMapper;
  final IChatRepository _chatRepository;
  final IChatMessageRepository _chatMessageRepository;

  final Map<GlobalSearchResultCategory, ISearchInteractor<List<ITileModel>>>
      _cache =
      <GlobalSearchResultCategory, ISearchInteractor<List<ITileModel>>>{};

  String _currentQuery = '';
  GlobalSearchResultCategory _currentCategory =
      GlobalSearchResultCategory.chats;

  final BehaviorSubject<GlobalSearchState> _stateSubject =
      BehaviorSubject<GlobalSearchState>.seeded(
    const GlobalSearchState(
      chatsPageState: PageState.data(models: <ITileModel>[]),
      filesPageState: PageState.data(models: <ITileModel>[]),
      mediaPageState: PageState.data(models: <ITileModel>[]),
      musicPageState: PageState.data(models: <ITileModel>[]),
      voicePageState: PageState.data(models: <ITileModel>[]),
      linksPageState: PageState.data(models: <ITileModel>[]),
    ),
  );

  Stream<GlobalSearchState> get stateStream => _stateSubject;

  GlobalSearchState get state => _stateSubject.value!;

  void onQuery(String query) {
    _currentQuery = query;
    if (query.isEmpty) {
      for (final ISearchInteractor<List<ITileModel>> s in _cache.values) {
        s.onQuery('');
      }
    } else {
      _cache[_currentCategory]!.onQuery(query);
    }
  }

  // todo fix extra delay after switch category if query is exits
  void onCategoryChanged(GlobalSearchResultCategory category) {
    if (_currentCategory != category) {
      _currentCategory = category;
      _cache[_currentCategory]!.onQuery(_currentQuery);
    }
  }

  void dispose() {
    _stateSubject.close();
  }

  PageState _mapToPageState(ISearchState state) {
    if (state is DefaultState) {
      return const PageState.data(models: <ITileModel>[]);
    } else if (state is LoadingState) {
      return const PageState.loading();
    } else if (state is ResultState<List<ITileModel>>) {
      return PageState.data(models: state.result);
    } else if (state is EmptyState) {
      return const PageState.empty();
    }
    throw StateError('unexpected state $state');
  }

  ISearchInteractor<List<ITileModel>> _createChatsSearchInteractor() =>
      _searchInteractorFactory.create<List<td.Chat>>(
        resultMapper: (List<td.Chat> result) => Future.wait(
          result.map(_resultTileMapper.mapToChatTileModel).toList(),
        ),
        resultFetcher: (String query) {
          return _chatRepository.findChats(query: query);
        },
        emptyTest: (List<td.Chat> value) => value.isEmpty,
      );

  ISearchInteractor<List<ITileModel>> _createMessagesSearchInteractor({
    required td.SearchMessagesFilter filter,
    required Future<ITileModel> Function(td.Message result) mapper,
  }) =>
      _searchInteractorFactory.create<List<td.Message>>(
        resultMapper: (List<td.Message> result) =>
            Future.wait(result.map(mapper).toList()),
        resultFetcher: (String query) {
          return _chatMessageRepository.findMessages(
            query: query,
            fromMessageId: 0,
            fromChatId: 0,
            // todo magic number
            limit: 15,
            filter: filter,
          );
        },
        emptyTest: (List<td.Message> value) => value.isEmpty,
      );
}
