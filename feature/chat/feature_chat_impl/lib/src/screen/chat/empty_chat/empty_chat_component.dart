import 'package:feature_chat_impl/src/di/chat_screen_component.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

import 'empty_chat_component_builder.dart';
import 'empty_chat_view_model.dart';

@j.Component(
  dependencies: <Type>[IChatScreenComponent],
  modules: <Type>[EmptyStateModule],
  builder: IEmptyChatComponentBuilder,
)
@j.singleton
abstract class IEmptyChatComponent {
  EmptyChatViewModel get viewModel;

  IStringsProvider get stringsProvider;
}

@j.module
abstract class EmptyStateModule {}
