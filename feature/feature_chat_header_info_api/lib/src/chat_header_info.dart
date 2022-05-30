import 'package:shared_models/shared_models.dart';

class ChatHeaderInfo {
  ChatHeaderInfo({
    required this.title,
    required this.subtitle,
    required this.avatar,
  });

  final String title;
  final String subtitle;

  final Avatar avatar;
}
