import 'package:feature_global_search_impl/src/screen/global_search/global_search_result_category.dart';

abstract class GlobalSearchEvent {
  const GlobalSearchEvent();
}

class InitEvent extends GlobalSearchEvent {
  const InitEvent();
}

class QueryChanged extends GlobalSearchEvent {
  const QueryChanged({
    required this.query,
  });

  final String query;
}

class CurrentPageChanged extends GlobalSearchEvent {
  const CurrentPageChanged({
    required this.category,
  });

  final GlobalSearchResultCategory category;
}

class OnChatTap extends GlobalSearchEvent {
  const OnChatTap({
    required this.chatId,
  });

  final int chatId;
}
