import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:td_api/td_api.dart' as td;

class ChatFilterRepositoryImpl implements IChatFilterRepository {
  ChatFilterRepositoryImpl({
    required ChatFilterDataSource dataSource,
  }) : _dataSource = dataSource;

  final ChatFilterDataSource _dataSource;

  @override
  Stream<List<td.ChatFilterInfo>> get chatFiltersStream =>
      _dataSource.chatFiltersStream;

  void dispose() {
    _dataSource.dispose();
  }
}
