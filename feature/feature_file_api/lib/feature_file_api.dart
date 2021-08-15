library feature_file_api;

abstract class IFileFeatureApi {
  IFileDownloader get fileDownloader;
}

abstract class IFileDownloader {
  Future<IFileDownloadState> getFileDownloadState(int fileId);

  Stream<IFileDownloadState> getFileDownloadStateStream(int fileId);

  Future<void> downloadFile(int fileId);
}

abstract class IFileDownloadState {}

class None implements IFileDownloadState {
  const None();
}

class Downloading implements IFileDownloadState {
  const Downloading({required this.progress});

  final int progress;
}

class Completed implements IFileDownloadState {
  const Completed({required this.path});

  final String path;
}
