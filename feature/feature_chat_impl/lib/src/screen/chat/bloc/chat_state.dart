import 'package:coreui/coreui.dart';
import 'package:equatable/equatable.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';

class ChatState extends Equatable {
  const ChatState({
    required this.headerState,
    required this.bodyState,
  });

  final HeaderState headerState;
  final BodyState bodyState;

  @override
  List<Object> get props => <Object>[
        headerState,
        bodyState,
      ];
}

class HeaderState extends Equatable {
  const HeaderState({required this.info});

  final ChatHeaderInfo info;

  @override
  List<Object> get props => <Object>[info];
}

abstract class BodyState extends Equatable {
  const BodyState();
}

class LoadingBodyState extends BodyState {
  const LoadingBodyState();

  @override
  List<Object?> get props => <dynamic>[];
}

class DataBodyState extends BodyState {
  const DataBodyState({required this.tiles});

  final List<ITileModel> tiles;

  @override
  List<Object> get props => <Object>[tiles];
}
