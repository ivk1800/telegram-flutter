import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:coreui/coreui.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_models/shared_models.dart' as shm;

class ImageWidgetFactory {
  ImageWidgetFactory({
    required IFileDownloader fileDownloader,
  }) : _fileDownloader = fileDownloader;

  final IFileDownloader _fileDownloader;

  Widget create(
    BuildContext context, {
    shm.Minithumbnail? minithumbnail,
    // TODO must be required
    int? imageId,
    ImageLayoutBuilder? layoutBuilder,
  }) {
    return _ImageScope(
      fileDownloader: _fileDownloader,
      minithumbnail: minithumbnail,
      layoutBuilder: layoutBuilder,
      imageId: imageId,
      child: const _ImageWidget(),
    );
  }
}

typedef ImageLayoutBuilder = Widget Function(Widget imageWidget);

class _ImageWidget extends StatefulWidget {
  const _ImageWidget();

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<_ImageWidget> {
  StreamSubscription<FileDownloadState>? _downloadImageSubscription;

  FileDownloadState _state = const FileDownloadState.none();
  int? _imageId;
  late IFileDownloader _fileDownloader;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final _ImageScope scope = _ImageScope.of(context);

    if (_imageId != scope.imageId || _fileDownloader != scope.fileDownloader) {
      _imageId = scope.imageId;
      _fileDownloader = scope.fileDownloader;
      _loadImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _Body(state: _state);
  }

  @override
  void dispose() {
    _downloadImageSubscription?.cancel();
    super.dispose();
  }

  void _loadImage() {
    _downloadImageSubscription?.cancel();

    Stream<FileDownloadState> stream;
    final int? imageId = _imageId;
    if (imageId != null) {
      stream =
          Stream<void>.fromFuture(_fileDownloader.startDownloadFile(imageId))
              .flatMap(
        (_) => _fileDownloader.getFileDownloadStateStream(imageId),
      );
    } else {
      // TODO photoId must be required
      stream = Stream<FileDownloadState>.value(const FileDownloadState.none());
    }
    _downloadImageSubscription = stream.listen((FileDownloadState newState) {
      setState(() {
        _state = newState;
      });
    });
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final FileDownloadState state;

  @override
  Widget build(BuildContext context) {
    final double progress = state.map(
      none: (None value) => _kMinimumProgress,
      downloading: (Downloading value) =>
          max(value.progress / 100, _kMinimumProgress),
      completed: (Completed value) => 1,
    );

    final bool isVisible = state.maybeMap(
      completed: (_) => false,
      orElse: () => true,
    );

    final String? imagePath = state.mapOrNull(
      completed: (Completed value) => value.path,
    );

    return Stack(
      children: <Widget>[
        _SwitchedImage(imagePath: imagePath),
        Align(
          child: _AnimatedCircularProgress(
            isVisible: isVisible,
            progress: progress,
          ),
        )
      ],
    );
  }

  static const double _kMinimumProgress = 0.05;
}

class _AnimatedCircularProgress extends StatefulWidget {
  const _AnimatedCircularProgress({
    required this.isVisible,
    required this.progress,
  });

  final double progress;
  final bool isVisible;

  @override
  State<_AnimatedCircularProgress> createState() =>
      _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<_AnimatedCircularProgress>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final Widget? child = widget.isVisible
        ? ConstrainedBox(
            constraints: BoxConstraints.tight(const Size.square(48)),
            child: CircularProgress(
              progress: widget.progress,
              vsync: this,
              child: const Icon(Icons.close, color: Colors.white),
            ),
          )
        : null;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }
}

class _SwitchedImage extends StatelessWidget {
  const _SwitchedImage({
    required this.imagePath,
  });

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    final shm.Minithumbnail? minithumbnail =
        _ImageScope.of(context).minithumbnail;
    final Widget? placeholder = minithumbnail != null
        ? Minithumbnail(minithumbnail: minithumbnail)
        : null;

    final String? imagePath = this.imagePath;
    return AnimatedSwitcher(
      switchOutCurve: const StaticCurve(),
      layoutBuilder: expandLayoutBuilder,
      duration: const Duration(milliseconds: 500),
      child: imagePath == null ? placeholder : _Image(path: imagePath),
    );
  }

  static Widget expandLayoutBuilder(
    Widget? currentChild,
    List<Widget> previousChildren,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ...previousChildren,
        if (currentChild != null) currentChild,
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final Image image = Image.file(
      File(path),
      fit: BoxFit.fill,
    );

    final ImageLayoutBuilder? layoutBuilder =
        _ImageScope.of(context).layoutBuilder;
    if (layoutBuilder != null) {
      return layoutBuilder.call(image);
    }
    return image;
  }
}

// TODO: replace by InheritedModel
class _ImageScope extends InheritedWidget {
  const _ImageScope({
    required super.child,
    required this.imageId,
    required this.minithumbnail,
    required this.fileDownloader,
    required this.layoutBuilder,
  });

  final int? imageId;
  final shm.Minithumbnail? minithumbnail;
  final IFileDownloader fileDownloader;
  final ImageLayoutBuilder? layoutBuilder;

  static _ImageScope of(BuildContext context) {
    final _ImageScope? result =
        context.dependOnInheritedWidgetOfExactType<_ImageScope>();
    assert(result != null, 'No _ImageScope found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ImageScope oldWidget) {
    return imageId != oldWidget.imageId ||
        minithumbnail != oldWidget.minithumbnail ||
        fileDownloader != oldWidget.fileDownloader ||
        layoutBuilder != oldWidget.layoutBuilder;
  }
}
