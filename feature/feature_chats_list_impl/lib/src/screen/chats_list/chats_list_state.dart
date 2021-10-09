import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'chats_list_state.freezed.dart';

@freezed
@immutable
class ChatsListState with _$ChatsListState {
  const factory ChatsListState.loading() = _Loading;
  const factory ChatsListState.data(List<ITileModel> models) = _Data;
}
