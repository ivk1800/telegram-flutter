import 'package:flutter/widgets.dart';
import 'package:tile/tile.dart';

/// message factory for external clients.
/// create messages in `message wall` context.
/// display user avatar and etc.
abstract class IInteractableMessageFactory {
  Widget create({
    required BuildContext context,
    required ITileModel model,
  });
}
