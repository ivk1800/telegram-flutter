import 'dart:async';
import 'dart:io';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_models/shared_models.dart';

import 'avatar_state.dart';

class AvatarViewModel {
  AvatarViewModel({
    required IFileDownloader fileDownloader,
    required Avatar avatar,
  })  : _fileDownloader = fileDownloader,
        _avatar = avatar {
    _loadAvatar();
  }

  final IFileDownloader _fileDownloader;
  Avatar _avatar;
  late final BehaviorSubject<AvatarState> _stateSubject =
      BehaviorSubject<AvatarState>.seeded(_getLoadingState());
  StreamSubscription<FileDownloadState>? _fileDownloadStateSubscription;

  Stream<AvatarState> get state => _stateSubject.distinct();

  // ignore: use_setters_to_change_properties
  void onNewAvatar(Avatar newAvatar) {
    _cancelLoadAvatar();
    _avatar = newAvatar;
    _loadAvatar();
  }

  void _loadAvatar() {
    final int? imageFileId = _avatar.imageFileId;
    if (imageFileId != null) {
      _fileDownloader.downloadFile(imageFileId);
      _fileDownloadStateSubscription = _fileDownloader
          .getFileDownloadStateStream(imageFileId)
          .listen(_onNewState);
    }
  }

  void _onNewState(FileDownloadState newState) {
    final AvatarState avatarState = newState.map(
      none: (_) {
        return _getLoadingState();
      },
      downloading: (_) {
        return _getLoadingState();
      },
      completed: (Completed state) {
        // return _getLoadingState();
        return AvatarState.file(file: File(state.path));
      },
    );
    _stateSubject.add(avatarState);
  }

  AvatarState _getLoadingState() {
    final Minithumbnail? minithumbnail = _avatar.minithumbnail;
    if (minithumbnail != null) {
      return AvatarState.thumbnail(thumbnail: minithumbnail);
    } else {
      return AvatarState.abbreviation(
        abbreviation: _avatar.abbreviation,
        objectId: _avatar.objectId,
      );
    }
  }

  void _cancelLoadAvatar() {
    _fileDownloadStateSubscription?.cancel();
  }

  void dispose() {
    _cancelLoadAvatar();
    _stateSubject.close();
  }
}
