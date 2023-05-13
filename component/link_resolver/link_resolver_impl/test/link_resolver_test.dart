/*
// TODO restore tests
// @dart=2.9

import 'package:link_resolver_api/src/resolve_result.dart';
import 'package:link_resolver_impl/link_resolver_impl.dart';
import 'package:test/test.dart';

void main() {
  LinkResolver resolver;

  setUp(() {
    resolver = LinkResolver();
  });

  group('https', () {
    test('should resolve username link', () async {
      final ResolveResult result = resolver.resolve('https://t.me/name');
      final String username = result.maybeMap(
        username: (Username value) => value.value,
        orElse: () => null,
      );
      expect('name', username);
    });
  });
}
*/
