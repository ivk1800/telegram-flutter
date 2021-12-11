import 'package:freezed_annotation/freezed_annotation.dart';

part 'panel_state.freezed.dart';

@freezed
@immutable
class PanelState with _$PanelState {
  const factory PanelState.empty() = Empty;
  const factory PanelState.channelSubscriber() = ChannelSubscriber;
  const factory PanelState.writer() = Writer;
}
