import 'package:link_resolver_api/link_resolver_api.dart';

/// android original: https://git.io/JXe4L
class LinkResolver implements ILinkResolver {
  @override
  ResolveResult resolve(String link) {
    try {
      return _resolveInternal(link);
    } on Exception {
      // todo log error
      return const ResolveResult.nothing();
    }
  }

  ResolveResult _resolveInternal(String link) {
    final Uri uri = Uri.parse(link);
    final String scheme = uri.scheme;

    switch (scheme) {
      case 'https':
        {
          return _resolveFromHttps(uri);
        }
    }
    return const ResolveResult.nothing();
  }

  ResolveResult _resolveFromHttps(Uri uri) {
    final String host = uri.host;

    if (host == 't.me') {
      final String path = uri.path;

      if (path.isNotEmpty) {
        if (path.length > 1) {
          final List<String> segments = uri.pathSegments;
          if (segments.isNotEmpty) {
            return ResolveResult.username(segments.first);
          }
        }
      }
    }

    return const ResolveResult.nothing();
  }
}
