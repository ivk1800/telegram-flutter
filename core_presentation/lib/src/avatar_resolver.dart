import 'package:core/core.dart';
import 'package:core_presentation/core_presentation.dart';
import 'package:core_utils/core_utils.dart';
import 'package:td_api/td_api.dart' as td;

class AvatarResolver {
  AvatarResolver({
    required OptionsManager optionsManager,
  }) : _optionsManager = optionsManager;

  final OptionsManager _optionsManager;

  late final Future<int> _myId = _optionsManager.getMyId();

  Future<Avatar> resolveForChat(td.Chat chat) async {
    final int myId = await _myId;

    if (myId == chat.id) {
      return const Avatar.savedMessages();
    }

    return Avatar.simple(
      abbreviation: getAvatarAbbreviation(first: chat.title, second: ''),
      objectId: chat.id,
      minithumbnail: chat.photo?.minithumbnail?.toMinithumbnail(),
      imageFileId: chat.photo?.small.id,
    );
  }
}
