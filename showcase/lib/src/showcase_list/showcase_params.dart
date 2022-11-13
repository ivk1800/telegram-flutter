import 'package:freezed_annotation/freezed_annotation.dart';

part 'showcase_params.freezed.dart';

@freezed
@immutable
class ShowcaseParams with _$ShowcaseParams {
  const factory ShowcaseParams.initialScreen() = InitialScreen;

  const factory ShowcaseParams.authScreen() = AuthScreen;
  const factory ShowcaseParams.createNewChannelScreen() =
      CreateNewChannelScreen;
  const factory ShowcaseParams.newContactScreen() = NewContactScreen;
  const factory ShowcaseParams.changeUsernameScreen() = ChangeUsernameScreen;
  const factory ShowcaseParams.mainScreen() = MainScreen;
  const factory ShowcaseParams.forumScreen() = ForumScreen;

  const factory ShowcaseParams.imageWidget() = ImageWidget;
  const factory ShowcaseParams.circularProgressWidget() =
      CircularProgressWidget;
  const factory ShowcaseParams.messageWrapWidget() = MessageWrapWidget;
  const factory ShowcaseParams.customEmojiWidget() = CustomEmojiWidget;
  const factory ShowcaseParams.avatarWidget() = AvatarWidget;

  const factory ShowcaseParams.splitView() = SplitView;
  const factory ShowcaseParams.chatMessages() = ChatMessages;
  const factory ShowcaseParams.chatCells() = ChatCells;
}
