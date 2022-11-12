import 'dart:convert';

import 'package:coreui/coreui.dart';
import 'package:flutter/material.dart';
import 'package:shared_models/shared_models.dart' as shm;
import 'package:showcase/src/showcase/image_widget/image_widget_showcase_scope_delegate.scope.dart';

class ImageWidgetShowcasePage extends StatelessWidget {
  const ImageWidgetShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with TickerProviderStateMixin {
  int imageId = 1;

  final shm.Minithumbnail minithumbnail = shm.Minithumbnail(
    height: 23,
    width: 40,
    data: const Base64Decoder().convert(_kMinithumbnail),
  );

  late final double aspectRation = minithumbnail.width / minithumbnail.height;

  @override
  Widget build(BuildContext context) {
    final ImageWidgetFactory imageWidgetFactory =
        ImageWidgetShowcaseScope.getImageWidgetFactory(context);

    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: AspectRatio(
            aspectRatio: aspectRation,
            child: imageWidgetFactory.create(
              context,
              imageId: imageId,
              minithumbnail: minithumbnail,
            ),
          ),
        ),
        const SizedBox(height: 16),
        MaterialButton(
          child: const Text('change image id'),
          onPressed: () {
            setState(() {
              imageId++;
            });
          },
        ),
      ],
    );
  }
}

const String _kMinithumbnail =
    '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDACgcHiMeGSgjISMtKygwPGRBPDc3PHtYXUlkkYCZlo+AjIqgtObDoKrarYqMyP/L2u71////m8H////6/+b9//j/2wBDASstLTw1PHZBQXb4pYyl+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj/wAARCAAXACgDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwC/TXlVM5Izj1xTqo3yyENsVjnqQO1cFGKlLU1k7Itb5PK8wiML/vdvr0pRMhxjv6cj86yXlT+zUiDYfecqM1YsvMKAOrbQRtYjgiuydGDWxmpM0aKKK8w2EdiqEjrVOa6ljt2ZSMjpx70UV3YaKabM5syTIS+/+LOfxrVt7uaWDLEZJ9MUUV1vYzLiElAT1oooryZ/EzdbH//Z';
