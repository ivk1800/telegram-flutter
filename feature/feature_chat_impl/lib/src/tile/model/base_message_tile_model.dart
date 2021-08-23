import 'package:tile/tile.dart';

abstract class BaseMessageTileModel implements ITileModel {
  const BaseMessageTileModel({
    required this.id,
    required this.isOutgoing,
  });

  final int id;
  final bool isOutgoing;
}
