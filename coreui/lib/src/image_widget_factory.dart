import 'dart:io';

import 'package:coreui/src/widget/minithumbnail_widget.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_models/shared_models.dart';

class ImageWidgetFactory {
  ImageWidgetFactory({
    required IFileDownloader fileDownloader,
  }) : _fileDownloader = fileDownloader;

  final IFileDownloader _fileDownloader;

  Widget create(
    BuildContext context, {
    Minithumbnail? minithumbnail,
    int? imageId,
    ImageLayoutBuilder? layoutBuilder,
  }) {
    return _ImageWidget(
      fileDownloader: _fileDownloader,
      minithumbnail: minithumbnail,
      photoId: imageId,
      layoutBuilder: layoutBuilder,
    );
  }
}

typedef ImageLayoutBuilder = Widget Function(Widget imageWidget);

class _ImageWidget extends StatefulWidget {
  const _ImageWidget({
    required this.photoId,
    required this.minithumbnail,
    required this.fileDownloader,
    this.layoutBuilder,
  });

  final int? photoId;
  final Minithumbnail? minithumbnail;
  final IFileDownloader fileDownloader;
  final ImageLayoutBuilder? layoutBuilder;

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<_ImageWidget> {
  late Stream<String>? _stream;

  @override
  void initState() {
    super.initState();
    _initPhoto(widget.photoId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final Minithumbnail? minithumbnail = widget.minithumbnail;
        final String? path = snapshot.data;
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            if (minithumbnail != null)
              MinithumbnailWidget(minithumbnail: minithumbnail),
            _Image(
              path: path,
              layoutBuilder: widget.layoutBuilder,
            ),
          ],
        );
      },
    );
  }

  @override
  void didUpdateWidget(_ImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.photoId != widget.photoId) {
      _initPhoto(widget.photoId);
    }
  }

  void _initPhoto(int? photoId) {
    if (photoId != null) {
      final IFileDownloader fileDownloader = widget.fileDownloader
        ..startDownloadFile(photoId);
      _stream = fileDownloader
          .getFileDownloadStateStream(photoId)
          // todo refactor filter state, do not check Completed state
          .where((FileDownloadState event) => event is Completed)
          .cast<Completed>()
          .map((Completed event) => event.path);
    } else {
      // todo not updated if new photo id is null
      _stream = null;
    }
  }
}

class _FinalImage extends StatelessWidget {
  const _FinalImage({
    required this.path,
    required this.layoutBuilder,
  });

  final String path;
  final ImageLayoutBuilder? layoutBuilder;

  @override
  Widget build(BuildContext context) {
    final Image image = Image.file(
      File(path),
      fit: BoxFit.fill,
    );

    final ImageLayoutBuilder? lb = layoutBuilder;
    if (lb != null) {
      return lb.call(image);
    }
    return image;
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.path,
    required this.layoutBuilder,
  });

  final String? path;
  final ImageLayoutBuilder? layoutBuilder;

  @override
  Widget build(BuildContext context) {
    final String? p = path;
    return AnimatedSwitcher(
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      duration: const Duration(milliseconds: 300),
      child: p == null
          ? null
          : _FinalImage(
              path: p,
              layoutBuilder: layoutBuilder,
            ),
    );
  }
}
