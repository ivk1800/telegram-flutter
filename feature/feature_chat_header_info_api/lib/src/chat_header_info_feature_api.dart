import 'chat_header_info_factory.dart';
import 'chat_header_info_interactor.dart';

abstract class IChatHeaderInfoFeatureApi {
  // todo: rename to create* or create factory for it
  IChatHeaderInfoInteractor getChatHeaderInfoInteractor(int chatId);

  IChatHeaderInfoFactory getChatHeaderInfoFactory();
}
