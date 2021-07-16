import 'package:flutter/rendering.dart';

import 'minithumbnail.dart';

// todo extract to common module
extension MinithumbnailExtensions on Minithumbnail {
  MemoryImage? toMemoryImage() {
    if (this != null) {
      return MemoryImage(data!);
    }
  }
}
