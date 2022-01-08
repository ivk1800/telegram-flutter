library link_resolver_api;

import 'src/resolve_result.dart';

export 'src/resolve_result.dart';

abstract class ILinkResolver {
  ResolveResult resolve(String link);
}
