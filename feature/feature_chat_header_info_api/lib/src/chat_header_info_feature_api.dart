import 'chat_header_info_factory.dart';
import 'chat_header_info_interactor.dart';

abstract class IChatHeaderInfoFeatureApi {
  IChatHeaderInfoInteractor getChatHeaderInfoInteractor(int chatId);

  IChatHeaderInfoFactory getChatHeaderInfoFactory();
}
