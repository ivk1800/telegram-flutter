import 'package:equatable/equatable.dart';

abstract class StickersEvent extends Equatable {
  const StickersEvent();

  @override
  List<Object> get props => <Object>[];
}

abstract class ActionEvent extends StickersEvent {
  const ActionEvent();
}

class TrendingStickersTap extends ActionEvent {
  const TrendingStickersTap();
}

class ArchivedStickersTap extends ActionEvent {
  const ArchivedStickersTap();
}

class MasksTap extends ActionEvent {
  const MasksTap();
}

class StickerSetTap extends ActionEvent {
  const StickerSetTap({required this.setId});

  final int setId;

  @override
  List<Object> get props => super.props + <Object>[setId];
}

class LoadingEvent extends StickersEvent {
  const LoadingEvent();
}
