import 'dart:convert';
import 'package:core_utils/core_utils.dart';
import 'package:shared_models/shared_models.dart';

class AvatarsRepository {
  Future<List<AvatarInfo>> getAvatars() async {
    return <AvatarInfo>[
      AvatarInfo(
        avatar: Avatar(
          abbreviation: getAvatarAbbreviation(
            first: 'firstName',
            second: 'lastName',
          ),
          imageFileId: null,
          objectId: 0,
        ),
        description: 'only abbreviation',
      ),
      AvatarInfo(
        avatar: Avatar(
          abbreviation: getAvatarAbbreviation(
            first: 'firstName',
            second: 'lastName',
          ),
          imageFileId: sOnlyMinithumbnail,
          objectId: sOnlyMinithumbnail,
          minithumbnail: Minithumbnail(
            data: const Base64Decoder().convert(sDurovMinithumbnail),
            width: 8,
            height: 8,
          ),
        ),
        description: 'only minithumbnail',
      ),
      AvatarInfo(
        avatar: Avatar(
          abbreviation: getAvatarAbbreviation(
            first: 'firstName',
            second: 'lastName',
          ),
          imageFileId: sLoadWithMinithumbnail,
          objectId: sLoadWithMinithumbnail,
          minithumbnail: Minithumbnail(
            data: const Base64Decoder().convert(sDurovMinithumbnail),
            width: 8,
            height: 8,
          ),
        ),
        description: 'load with minithumbnail',
      ),
    ];
  }

  static int sOnlyMinithumbnail = 1;
  static int sLoadWithMinithumbnail = 2;

  static String sDurovMinithumbnail =
      '/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDACgcHiMeGSgjISMtKygwPGRBPDc3PHtYXUlkkYCZlo+AjIqgtObDoKrarYqMyP/L2u71////m8H////6/+b9//j/2wBDASstLTw1PHZBQXb4pYyl+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj/wAARCAAIAAgDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwCnFtLsN25ieKKKKEJn/9k=';
}

class AvatarInfo {
  AvatarInfo({
    required this.avatar,
    required this.description,
  });

  final Avatar avatar;

  final String description;
}
