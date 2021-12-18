import 'package:freezed_annotation/freezed_annotation.dart';

part 'panel_state.freezed.dart';

@freezed
@immutable
class PanelState with _$PanelState {
  const factory PanelState.empty() = Empty;
  const factory PanelState.join() = Join;
  const factory PanelState.channelSubscriber({required bool isMuted}) =
      ChannelSubscriber;
  const factory PanelState.writer() = Writer;
}
