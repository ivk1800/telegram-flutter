import 'package:coreui/coreui.dart';

import 'avatar_showcase_repository.dart';

class AvatarShowcaseComponent {
  AvatarShowcaseComponent({
    required this.avatarWidgetFactory,
    required this.avatarsRepository,
  });

  final AvatarWidgetFactory avatarWidgetFactory;

  final AvatarsRepository avatarsRepository;
}
