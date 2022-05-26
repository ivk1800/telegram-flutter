import 'package:flutter/widgets.dart';

import 'chat_header_info.dart';

abstract class IChatHeaderInfoFactory {
  Widget create({
    required BuildContext context,
    required ChatHeaderInfo info,
    void Function()? onProfileTap,
  });
}
