import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_list_type.freezed.dart';

@freezed
@immutable
class ChatListType with _$ChatListType {
  const factory ChatListType.main() = ChatListMain;
  const factory ChatListType.archive() = ChatListArchive;
  const factory ChatListType.filter({
    required int chatFilterId,
  }) = ChatListFilter;
}
