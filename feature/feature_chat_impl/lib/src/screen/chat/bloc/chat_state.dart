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
  }) = _Data;
}

//
class HeaderState extends Equatable {
  const HeaderState({required this.info});

  final ChatHeaderInfo info;

  @override
  List<Object> get props => <Object>[info];
}
