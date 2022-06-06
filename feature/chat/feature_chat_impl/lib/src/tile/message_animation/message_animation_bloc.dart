import 'package:feature_chat_impl/src/tile/bloc/media_mixin.dart';
import 'package:feature_chat_impl/src/tile/bloc/message_bloc.dart';
import 'package:feature_chat_impl/src/tile/message_animation/message_animation_tile_model.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:jugger/jugger.dart' as j;

class MessageAnimationBloc extends MessageBloc<MessageAnimationTileModel>
    with MediaMixin<MessageAnimationTileModel> {
  @j.inject
  MessageAnimationBloc({
    required IFileDownloader fileDownloader,
  }) : _fileDownloader = fileDownloader;

  final IFileDownloader _fileDownloader;

  @override
  void onModelChanged() {
    download(model.animationFileId);
  }

  @override
  IFileDownloader get fileDownloader => _fileDownloader;
}
