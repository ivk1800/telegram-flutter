import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'header_state.freezed.dart';

@freezed
@immutable
class HeaderState with _$HeaderState {
  const factory HeaderState.data(
    ChatHeaderInfo info,
    List<HeaderActionData> actions,
  ) = HeaderData;
}

class HeaderActionData {
  HeaderActionData({required this.action, required this.label});

  final HeaderAction action;

  final String label;
}

enum HeaderAction { leave }
