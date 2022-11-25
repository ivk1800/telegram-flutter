import 'package:core_presentation/core_presentation.dart';
import 'package:coreui/src/avatar/avatar_view_model.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:flutter/material.dart';
import 'package:fwg_annotation/fwg_annotation.dart';

import 'avatar.dart' as aw;
import 'avatar_scope.dart';

part 'avatar_widget_factory.fwg.dart';

@widgetFactory
class AvatarWidgetFactory {
  AvatarWidgetFactory({
    required IFileDownloader fileDownloader,
  }) : _fileDownloader = fileDownloader;

  final IFileDownloader _fileDownloader;

  // todo move to core ui module
  /// https://github.com/DrKLO/Telegram/blob/ca13bc972dda0498b8ffb40276423a49325cd26d/TMessagesProj/src/main/java/org/telegram/ui/ActionBar/Theme.java#L3151
  static const List<Color> colors = <Color>[
    Color(0xffe56555),
    Color(0xfff28c48),
    Color(0xff8e85ee),
    Color(0xff76c84d),
    Color(0xff5fbed5),
    Color(0xff549cdd),
    Color(0xfff2749a),
  ];

  Widget create(
    BuildContext context, {
    required Avatar avatar,
    double? radius,
    BorderRadius? borderRadius,
  }) {
    return AvatarScope(
      child: aw.Avatar(
        radius: radius ?? 20,
        avatar: avatar,
        borderRadius: borderRadius ??
            const BorderRadius.all(
              Radius.circular(kDefaultBorderRadius),
            ),
      ),
      create: () {
        return AvatarViewModel(
          fileDownloader: _fileDownloader,
          avatar: avatar,
        );
      },
    );
  }

  static const double kDefaultBorderRadius = 45;
}
