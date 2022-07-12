import 'package:core/core.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localization_api/localization_api.dart';
import 'package:td_api/td_api.dart' as td;

part 'username_checker.freezed.dart';

class UsernameChecker {
  UsernameChecker({
    required ITdFunctionExecutor functionExecutor,
    required IStringsProvider stringsProvider,
    required OptionsManager optionsManager,
  })  : _functionExecutor = functionExecutor,
        _optionsManager = optionsManager,
        _stringsProvider = stringsProvider;

  final ITdFunctionExecutor _functionExecutor;
  final IStringsProvider _stringsProvider;
  final OptionsManager _optionsManager;

  // TODO implement local check
  // https://github.com/DrKLO/Telegram/blob/ca13bc972dda0498b8ffb40276423a49325cd26d/TMessagesProj/src/main/java/org/telegram/ui/ChangeUsernameActivity.java#L244
  Future<CheckResult> check(String username) async {
    final int myId = await _optionsManager.getMyId();

    final td.Chat myChat = await _functionExecutor.send<td.Chat>(
      td.CreatePrivateChat(userId: myId, force: false),
    );

    final td.CheckChatUsernameResult result =
        await _functionExecutor.send<td.CheckChatUsernameResult>(
      td.CheckChatUsername(chatId: myChat.id, username: username),
    );

    return result.map(
      ok: (_) => const CheckResult.ok(),
      usernameInvalid: (_) =>
          CheckResult.error(_stringsProvider.usernameInvalid),
      usernameOccupied: (_) =>
          CheckResult.error(_stringsProvider.usernameInUse),
      publicChatsTooMuch: (_) => const CheckResult.error('publicChatsTooMuch'),
      publicGroupsUnavailable: (_) =>
          const CheckResult.error('publicGroupsUnavailable'),
    );
  }
}

@freezed
@immutable
class CheckResult with _$CheckResult {
  const factory CheckResult.error(String textForDisplay) = CheckResultError;

  const factory CheckResult.ok() = CheckResultOk;
}
