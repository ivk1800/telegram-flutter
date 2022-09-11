import 'package:feature_stickers_api/feature_stickers_api.dart';
import 'package:feature_stickers_impl/src/di/stickers_component.dart';
import 'package:feature_stickers_impl/src/di/stickers_component.jugger.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/stickers_set_page.dart';
import 'package:feature_stickers_impl/src/screen/stickers_set/stickers_set_screen_scope_delegate.scope.dart';
import 'package:flutter/widgets.dart';

class StickerSetWidgetFactory implements IStickerSetScreenFactory {
  StickerSetWidgetFactory({required this.parentComponent});

  final IStickersComponent parentComponent;

  @override
  Widget create(int setId) {
    return StickersSetScreenScope(
      create: () => parentComponent.createStickersSetScreenComponent(
        JuggerSubcomponent$StickersSetScreenComponentBuilder().setId(setId),
      ),
      child: const StickerSetPage(),
    );
  }
}
