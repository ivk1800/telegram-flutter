// @dart=2.9

import 'dart:collection';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:fake/fake.dart';
import 'package:feature_chats_list_impl/src/list/chat_data.dart';
import 'package:feature_chats_list_impl/src/list/chat_list.dart';
import 'package:feature_chats_list_impl/src/list/ordered_chat.dart';
import 'package:feature_chats_list_impl/src/mapper/chat_tile_model_mapper.dart';
import 'package:feature_chats_list_impl/src/tile/chat_tile_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:test/test.dart';

import 'chat_list_update_handler_test.mocks.dart';

@GenerateMocks(
  <Type>[
    IChatRepository,
    ChatListConfig,
    IChatsHolder,
    ChatTileModelMapper,
  ],
)
void main() {
  setUp(() {
    _currentTestScope = TestScope();
  });

  tearDown(() {
    _currentTestScope = null;
  });

  group('new position', _newPositionGroup);
}

TestScope _currentTestScope;

class TestScope {
  IChatRepository mockChatRepository;
  ChatListConfig mockChatListConfig;
  IChatsHolder mockChatsHolder;
  ChatTileModelMapper mockChatTileModelMapper;

  ChatListUpdateHandler handler;

  final SplayTreeSet<OrderedChat> orderedChats = SplayTreeSet<OrderedChat>();
  final Map<int, ChatData> chats = <int, ChatData>{};

  TestScope() {
    mockChatRepository = MockIChatRepository();
    mockChatListConfig = MockChatListConfig();
    mockChatsHolder = MockIChatsHolder();
    mockChatTileModelMapper = MockChatTileModelMapper();

    when(mockChatListConfig.chatList).thenAnswer(
      (_) => const td.ChatListMain(),
    );

    when(mockChatTileModelMapper.mapToModel(any)).thenAnswer(
      (_) {
        return Future<ChatTileModel>.value(
          const ChatTileModel(
            secondSubtitle: '',
            photoId: 0,
            lastMessageDate: '',
            isVerified: false,
            isSecret: false,
            isRead: false,
            isMentioned: false,
            firstSubtitle: '',
            isMuted: false,
            id: 0,
            title: '',
            isPinned: false,
            unreadMessagesCount: 0,
          ),
        );
      },
    );

    when(mockChatsHolder.chatsData).thenAnswer((_) => chats);
    when(mockChatsHolder.orderedChats).thenAnswer((_) => orderedChats);

    handler = ChatListUpdateHandler(
      chatRepository: mockChatRepository,
      chatListConfig: mockChatListConfig,
      chatsHolder: mockChatsHolder,
      chatTileModelMapper: mockChatTileModelMapper,
    );
  }

  void doMockTestChat() {
    when(mockChatRepository.getChat(any)).thenAnswer(
      (_) => Future<td.Chat>.value(
        _createChat(
          id: kTestChatId,
          positions: <td.ChatPosition>[
            const td.ChatPosition(
              order: 7074313342742953984,
              isPinned: false,
              list: td.ChatListMain(),
            ),
          ],
        ),
      ),
    );
  }
}

void _newPositionGroup() {
  test('should remove chat if position is empty', () async {
    _currentTestScope.doMockTestChat();

    await _currentTestScope.handler.handleNewPosition(
      kTestChatId,
      const td.ChatPosition(
        order: 7074313342742953984,
        isPinned: false,
        list: td.ChatListMain(),
      ),
    );

    await _currentTestScope.handler.handleNewPositions(
      chatId: kTestChatId,
      positions: <td.ChatPosition>[],
    );

    assert(_currentTestScope.chats.isEmpty);
    assert(_currentTestScope.orderedChats.isEmpty);
  });
}

td.Chat _createChat({
  int id,
  List<td.ChatPosition> positions,
}) {
  return createFakeChat(
    id: id,
    positions: positions,
  );
}

const int kTestChatId = 1;
