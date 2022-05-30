import 'minithumbnail.dart';

class Avatar {
  const Avatar({
    required this.objectId,
    required this.imageFileId,
    required this.abbreviation,
    this.minithumbnail,
  });

  final int objectId;
  final String abbreviation;
  final Minithumbnail? minithumbnail;
  final int? imageFileId;
}
