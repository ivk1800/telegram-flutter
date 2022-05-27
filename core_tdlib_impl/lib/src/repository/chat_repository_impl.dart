import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:tdlib/td_api.dart' as td;

class ChatRepositoryImpl extends IChatRepository {
  ChatRepositoryImpl({
    required ChatDataSource dataSource,
  }) : _dataSource = dataSource;

  final ChatDataSource _dataSource;

  @override
  Future<td.Chat> getChat(int id) => _dataSource.getChat(id);

  @override
  Future<List<td.Chat>> getChats({
    required int offsetChatId,
    required int offsetOrder,
    required int limit,
    required td.ChatList chatList,
  }) =>
      _dataSource.getChats(
        offsetChatId: offsetChatId,
        offsetOrder: offsetOrder,
        limit: limit,
        chatList: chatList,
      );

  @override
  Future<List<td.Chat>> findChats({
    required String query,
  }) =>
      _dataSource.findChats(query: query);
}
