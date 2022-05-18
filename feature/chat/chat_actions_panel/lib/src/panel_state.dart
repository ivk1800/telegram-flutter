import 'package:freezed_annotation/freezed_annotation.dart';

part 'panel_state.freezed.dart';

@freezed
@immutable
class PanelState with _$PanelState {
  const factory PanelState.empty() = EmptyState;
  const factory PanelState.join() = JoinState;
  const factory PanelState.channelSubscriber({required bool isMuted}) =
      ChannelSubscriberState;
  const factory PanelState.writer() = WriterState;
}
