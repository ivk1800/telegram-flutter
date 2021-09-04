import 'dart:io';
import 'dart:ui';

import 'package:core_utils/core_utils.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    Key? key,
    required this.photoId,
    required this.minithumbnail,
    required this.fileDownloader,
    this.layoutBuilder,
  }) : super(key: key);

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
            if (minithumbnail != null) _buildMinithumbnail(minithumbnail),
            _buildImage(path),
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
      final IFileDownloader fileDownloader = widget.fileDownloader;
      fileDownloader.downloadFile(photoId).catchError(print);
      _stream = fileDownloader
          .getFileDownloadStateStream(photoId)
          .where((IFileDownloadState event) => event is Completed)
          .cast<Completed>()
          .map((Completed event) => event.path);
    } else {
      // todo not updated if new photo id is null
      _stream = null;
    }
  }

  Widget _buildMinithumbnail(Minithumbnail minithumbnail) {
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Image.memory(
          minithumbnail.data!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildImage(String? path) {
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
      child: path == null ? null : _build(path),
    );
  }

  Widget _build(String path) {
    final Image image = Image.file(
      File(path),
      fit: BoxFit.fill,
    );

    if (widget.layoutBuilder != null) {
      return widget.layoutBuilder!.call(image);
    }
    return image;
  }
}
