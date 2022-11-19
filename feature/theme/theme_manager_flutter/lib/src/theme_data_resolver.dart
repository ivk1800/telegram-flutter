import 'package:chat_list_theme/chat_list_theme.dart';
import 'package:flutter/material.dart';
import 'package:tg_theme/tg_theme.dart';
import 'package:theme_manager_api/theme_manager_api.dart' as th;

class ThemeDataResolver {
  const ThemeDataResolver();

  ThemeData resolve(th.Theme theme) {
    return theme.map(
      classic: (_) {
        return ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
          platform: TargetPlatform.android,
          primaryColor: kPrimaryColor,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                secondary: kSecondaryColor,
              ),
          appBarTheme: const AppBarTheme(
            color: Color(0xff5682a3),
          ),
          extensions: <ThemeExtension<Object?>>[
            ChatCellTheme.light,
            TgTextTheme.light(),
          ],
        );
      },
      dark: (_) {
        return ThemeData.dark().copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            },
          ),
          platform: TargetPlatform.android,
          extensions: <ThemeExtension<Object?>>[
            ChatCellTheme.light,
          ],
        );
      },
    );
  }
}
