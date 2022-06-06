import 'dart:async';
import 'dart:io';

import 'package:feature_chat_impl/src/tile/bloc/message_bloc.dart';
import 'package:feature_chat_impl/src/tile/model/base_message_tile_model.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'media_mixin.freezed.dart';

mixin MediaMixin<Model extends BaseMessageTileModel> on MessageBloc<Model> {
  final BehaviorSubject<MediaState> _mediaStateSubject =
      BehaviorSubject<MediaState>.seeded(const MediaState.loading());

  Stream<MediaState> get mediaState => _mediaStateSubject;

  abstract final IFileDownloader fileDownloader;

  StreamSubscription<dynamic>? _fileStreamSubscription;

  void download(int fileId) {
    _fileStreamSubscription?.cancel();
    fileDownloader.downloadFile(fileId);
    _fileStreamSubscription = fileDownloader
        .getFileDownloadStateStream(fileId)
        .map((FileDownloadState fileState) {
          return fileState.map(
            none: (_) {
              return const MediaState.loading();
            },
            downloading: (_) {
              return const MediaState.loading();
            },
            completed: (Completed completed) {
              return MediaState.loaded(File(completed.path));
            },
          );
        })
        .startWith(const MediaState.loading())
        .listen(_setState);
  }

  @override
  void onDispose() {
    _fileStreamSubscription?.cancel();
    _mediaStateSubject.close();
    super.onDispose();
  }

  void _setState(MediaState state) {
    _mediaStateSubject.add(state);
  }
}

@freezed
@immutable
class MediaState with _$MediaState {
  const factory MediaState.loading() = MediaStateLoading;

  const factory MediaState.loaded(File file) = MediaStateLoaded;
}
