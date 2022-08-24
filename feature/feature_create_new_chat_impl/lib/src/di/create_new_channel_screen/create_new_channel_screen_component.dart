import 'package:feature_create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:feature_create_new_chat_impl/src/di/scope/screen_scope.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_channel/new_channel_screen_router.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_channel/new_channel_view_model.dart';
import 'package:feature_create_new_chat_impl/src/screen/new_channel/new_channel_widget_model.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.Subcomponent(
  modules: <Type>[CreateNewChannelScreenModule],
)
@screenScope
abstract class ICreateNewChannelScreenComponent {
  NewChannelViewModel getNewChannelViewModel();

  IStringsProvider getStringsProvider();

  NewChannelWidgetModel getNewChannelWidgetModel();
}

@j.module
abstract class CreateNewChannelScreenModule {
  @screenScope
  @j.provides
  static NewChannelWidgetModel provideNewChannelController(
    NewChannelViewModel viewModel,
  ) =>
      NewChannelWidgetModel(viewModel: viewModel);

  @j.binds
  @screenScope
  INewChannelScreenRouter bindNewChannelScreenRouter(ICreateNewChatRouter impl);
}
