import 'package:flutter/widgets.dart';
import 'package:td_client/td_client.dart';
import 'package:tdlib/td_api.dart' as td;

class TdImageLoader extends StatefulWidget {
  const TdImageLoader({Key? key, required this.child, required this.client})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TdImageLoaderState();

  final Widget child;

  final TdClient client;

  static TdImageLoaderState of(BuildContext context) {
    return context.findRootAncestorStateOfType<TdImageLoaderState>()!;
  }
}

class TdImageLoaderState extends State<TdImageLoader> {
  @override
  Widget build(BuildContext context) => widget.child;

  void load(td.File image) {
    if (!image.local.isDownloadingActive &&
        !image.local.isDownloadingCompleted) {
      widget.client.send<td.File>(td.DownloadFile(
          fileId: image.id,
          priority: 1,
          limit: 0,
          offset: 0,
          synchronous: false));
    }
  }
}
