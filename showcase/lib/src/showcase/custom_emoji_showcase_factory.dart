import 'package:feature_chat_forum_impl/feature_chat_forum_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'custom_emoji/custom_emoji_showcase_page.dart';

class CustomEmojiShowcaseFactory {
  @j.inject
  CustomEmojiShowcaseFactory();

  Widget create(BuildContext context) {
    return const CustomEmojiShowcasePage();
  }
}
