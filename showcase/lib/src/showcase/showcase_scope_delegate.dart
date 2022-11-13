import 'package:scope_generator_annotation/scope_generator_annotation.dart';
import 'package:showcase/src/showcase_list/showcase_info_resolver.dart';

import 'message/message_showcase_factory.dart';
import 'widget/showcase_block_interaction_manager.dart';

@scope
abstract class IShowcaseScopeDelegate {
  ShowcaseBlockInteractionManager getShowcaseBlockInteractionManager();

  MessageShowcaseFactory getMessageShowcaseFactory();

  ShowcaseInfoResolver getShowcaseInfoResolver();
}
