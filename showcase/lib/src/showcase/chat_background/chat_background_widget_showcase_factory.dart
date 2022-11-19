import 'dart:io';

import 'package:chat_kit/chat_kit.dart';
import 'package:fake/fake.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:showcase/src/showcase/chat_background/chat_background_type.dart';
import 'package:td_api/td_api.dart' as td;
import 'chat_background_showcase_page.dart';
import 'chat_background_widget_showcase_scope_delegate.dart';
import 'chat_background_widget_showcase_scope_delegate.scope.dart';

class ChatBackgroundWidgetShowcaseFactory {
  @j.inject
  const ChatBackgroundWidgetShowcaseFactory();

  Widget create(
    BuildContext context, {
    required ChatBackgroundType type,
  }) {
    return ChatBackgroundWidgetShowcaseScope(
      create: () => _Delegate(type: type),
      child: const ChatBackgroundShowcasePage(),
    );
  }
}

class _Delegate implements IChatBackgroundWidgetShowcaseScopeDelegate {
  _Delegate({required ChatBackgroundType type}) : _type = type;

  final ChatBackgroundType _type;

  late final ChatBackgroundManager _manager = ChatBackgroundManager(
    fileDownloader: FakeFileDownloader(
      downloadFileProvider: (int fileId) async {
        final File tgvFile = await readFileFromAssets(
          key: 'packages/fake/assets/file/background/file_1608.tgv',
          // key: 'packages/showcase/assets/file_1608.tgv',
          fileName: 'file_1608.tgv',
        );
        return tgvFile;
      },
    ),
    patternBackgroundFileResolver: const PatternBackgroundFileResolver(),
    activeBackgroundStorage: ActiveBackgroundStorage(),
    authenticationStateUpdatesProvider:
        FakeAuthenticationStateUpdatesProvider(),
    authenticationStateProvider: const FakeAuthenticationStateProvider(
      authorizationState: td.AuthorizationStateReady(),
    ),
    backgroundRepository: FakeBackgroundRepository(
      fakeBackgrounds: () async {
        switch (_type) {
          case ChatBackgroundType.solid:
            return <td.Background>[_createSolidBackground()];
          case ChatBackgroundType.pattern:
            return <td.Background>[
              createBackground().copyWith(
                document: createDocument().copyWith(
                  mimeType: 'application/x-tgwallpattern',
                ),
                type: const td.BackgroundTypePattern(
                  fill: td.BackgroundFillSolid(color: 0),
                  intensity: 0,
                  isInverted: false,
                  isMoving: false,
                ),
              )
            ];
          case ChatBackgroundType.gradient:
            return <td.Background>[_createSolidBackground()];
          case ChatBackgroundType.freeformGradient:
            return <td.Background>[_createFreeformGradient()];
          case ChatBackgroundType.wallpaper:
            return <td.Background>[_createSolidBackground()];
        }
      },
    ),
  );

  td.Background _createFreeformGradient() {
    return createBackground().copyWith(
      type: const td.BackgroundTypeFill(
        fill: td.BackgroundFillFreeformGradient(
          colors: <int>[16703019, 3121110, 9661932, 16681655],
        ),
      ),
    );
  }

  td.Background _createSolidBackground() {
    return createBackground().copyWith(
      type: const td.BackgroundTypeFill(
        fill: td.BackgroundFillSolid(
          color: 16703019,
        ),
      ),
    );
  }

  late final ChatBackgroundFactory _factory = ChatBackgroundFactory(
    backgroundListenable: BackgroundListenable(
      chatBackgroundManager: _manager,
    ),
  );

  @override
  ChatBackgroundFactory getChatBackgroundFactory() => _factory;

  @override
  ChatBackgroundType getChatBackgroundType() => _type;
}
