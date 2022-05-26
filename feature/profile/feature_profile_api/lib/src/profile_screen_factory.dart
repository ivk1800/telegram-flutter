import 'package:flutter/widgets.dart';
import 'package:profile_navigation_api/profile_navigation_api.dart';

abstract class IProfileScreenFactory {
  Widget create(int id, ProfileType type);
}
