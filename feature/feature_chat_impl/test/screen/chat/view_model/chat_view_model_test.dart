// @dart=2.9

import 'package:chat_manager_api/chat_manager_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_chat_impl/feature_chat_impl.dart';
import 'package:feature_chat_impl/src/interactor/chat_header_actions_intractor.dart';
import 'package:feature_chat_impl/src/interactor/chat_messages_list_interactor.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_args.dart';
import 'package:feature_chat_impl/src/screen/chat/chat_screen.dart';
import 'package:localization_api/localization_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'chat_view_model_test.mocks.dart';

@GenerateMocks(
  <Type>[
    ChatArgs,
    IChatScreenRouter,
    ILocalizationManager,
    IChatHeaderInfoInteractor,
    ChatHeaderActionsInteractor,
  ],
  customMocks: <MockSpec<dynamic>>[
    MockSpec<ChatMessagesInteractor>(returnNullOnMissingStub: true),
    MockSpec<IChatManager>(returnNullOnMissingStub: true)
  ],
)
void main() {
  ChatArgs mockChatArgs;
  IChatScreenRouter mockChatScreenRouter;
  ChatMessagesInteractor mockChatMessagesInteractor;
  IChatManager mockChatManager;

  ChatMessagesViewModel viewModel;

  setUp(() {
    mockChatArgs = MockChatArgs();
    mockChatScreenRouter = MockIChatScreenRouter();
    mockChatMessagesInteractor = MockChatMessagesInteractor();
    mockChatManager = MockIChatManager();

    when(mockChatArgs.chatId).thenReturn(0);

    viewModel = ChatMessagesViewModel(
      args: mockChatArgs,
      router: mockChatScreenRouter,
      chatManager: mockChatManager,
      messagesInteractor: mockChatMessagesInteractor,
    );
  });

  test('should mark opened chat on init', () async {
    viewModel.init();
    verify(mockChatManager.markAsOpenedChat(any)).called(1);
  });

  test('should mark opened chat on dispose', () async {
    viewModel.dispose();
    verify(mockChatManager.markAsClosedChat(any)).called(1);
  });

  test('should dispose messages interactor on dispose', () async {
    viewModel.dispose();
    verify(mockChatMessagesInteractor.dispose()).called(1);
  });
}
