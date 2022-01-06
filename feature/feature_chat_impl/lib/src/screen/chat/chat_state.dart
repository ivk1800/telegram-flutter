import 'package:equatable/equatable.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tile/tile.dart';

part 'chat_state.freezed.dart';

@freezed
@immutable
class BodyState with _$BodyState {
  const factory BodyState.loading() = _Loading;

  const factory BodyState.data({
    required List<ITileModel> models,
  }) = Data;
}

//
class HeaderState extends Equatable {
  const HeaderState({
    required this.info,
    required this.actions,
  });

  final ChatHeaderInfo info;

  final List<HeaderActionData> actions;

  @override
  List<Object> get props => <Object>[info, actions];
}

class HeaderActionData {
  HeaderActionData({required this.action, required this.label});

  final HeaderAction action;

  final String label;
}

enum HeaderAction { leave }
