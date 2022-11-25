import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:fake/fake.dart' as fake;
import 'package:localization_api/localization_api.dart';
import 'package:localization_impl/localization_impl.dart';
import 'package:td_api/td_api.dart' as td;

class FakeProvider {
  IChatRepository getChatRepository() {
    return const fake.FakeChatRepository();
  }

  ILocalizationManager getLocalizationManager() {
    return LocalizationManager();
  }

  IBasicGroupRepository getBasicGroupRepository() {
    return const fake.FakeBasicGroupRepository();
  }

  ISuperGroupRepository getSuperGroupRepository() {
    return const fake.FakeSuperGroupRepository();
  }

  IUserRepository getUserRepository() {
    return fake.FakeUserRepository(
      fakeUserProvider: const fake.FakeUserProvider(),
    );
  }

  IFileRepository getFileRepository() {
    return const fake.FakeFileRepository();
  }

  IConnectionStateProvider getConnectionStateProvider() {
    return const fake.FakeConnectionStateProvider();
  }

  IChatMessageRepository getChatMessageRepository() {
    return const fake.FakeChatMessageRepository(fakeMessages: <td.Message>[]);
  }
}
