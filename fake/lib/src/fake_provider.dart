import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:fake/fake.dart' as fake;
import 'package:localization_api/localization_api.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:tdlib/td_api.dart' as td;

class FakeProvider {
  IChatRepository getChatRepository() {
    return fake.FakeChatRepository();
  }

  ILocalizationManager getLocalizationManager() {
    return LocalizationManager();
  }

  IBasicGroupRepository getBasicGroupRepository() {
    return fake.FakeBasicGroupRepository();
  }

  ISuperGroupRepository getSuperGroupRepository() {
    return fake.FakeSuperGroupRepository();
  }

  IUserRepository getUserRepository() {
    return fake.FakeUserRepository(fakeUserProvider: fake.FakeUserProvider());
  }

  IFileRepository getFileRepository() {
    return const fake.FakeFileRepository();
  }

  IConnectionStateProvider getConnectionStateProvider() {
    return fake.FakeConnectionStateProvider();
  }

  IChatMessageRepository getChatMessageRepository() {
    return fake.FakeChatMessageRepository(fakeMessages: <td.Message>[]);
  }
}
