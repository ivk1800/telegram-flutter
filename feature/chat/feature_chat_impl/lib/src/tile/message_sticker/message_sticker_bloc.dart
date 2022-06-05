import 'dart:async';
import 'dart:io';

import 'package:feature_chat_impl/src/tile/bloc/message_bloc.dart';
import 'package:feature_chat_impl/src/tile/model/message_sticker_tile_model.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:lottie_utils/lottie_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sticker_navigation_api/sticker_navigation_api.dart';

import 'message_sticker_state.dart';

class MessageStickerBloc
    extends MessageBloc<MessageStickerTileModel, MessageStickerState> {
  @j.inject
  MessageStickerBloc({
    required IFileDownloader fileDownloader,
    required IStickersSetScreenRouter stickersSetScreenRouter,
    required LottieStickerFileResolver lottieStickerFileResolver,
  })  : _fileDownloader = fileDownloader,
        _lottieStickerFileResolver = lottieStickerFileResolver,
        _stickersSetScreenRouter = stickersSetScreenRouter;

  final IFileDownloader _fileDownloader;
  final IStickersSetScreenRouter _stickersSetScreenRouter;
  final LottieStickerFileResolver _lottieStickerFileResolver;

  StreamSubscription<dynamic>? _fileStreamSubscription;

  @override
  void onModelChanged() {
    _fileStreamSubscription?.cancel();
    _fileDownloader.downloadFile(model.stickerFileId);
    _fileStreamSubscription = _fileDownloader
        .getFileDownloadStateStream(model.stickerFileId)
        .map((FileDownloadState fileState) {
          return fileState.map(
            none: (_) {
              return const MessageStickerState.loading();
            },
            downloading: (_) {
              return const MessageStickerState.loading();
            },
            completed: (Completed completed) {
              if (model.isAnimated) {
                return MessageStickerState.loadedAnimated(File(completed.path));
              } else {
                return MessageStickerState.loadedStatic(File(completed.path));
              }
            },
          );
        })
        .startWith(const MessageStickerState.loading())
        .asyncMap((MessageStickerState state) async {
          if (state is MessageStickerStateLoadedAnimated) {
            final File lottieFile = await _lottieStickerFileResolver.resolve(
              state.file.path,
            );
            return MessageStickerState.loadedAnimated(lottieFile);
          }
          return state;
        })
        .listen(setState);
  }

  @override
  void onDispose() {
    _fileStreamSubscription?.cancel();
    super.onDispose();
  }

  void onStickerTap() {
    // todo can be 0
    _stickersSetScreenRouter.toStickersSet(model.setId);
  }
}
