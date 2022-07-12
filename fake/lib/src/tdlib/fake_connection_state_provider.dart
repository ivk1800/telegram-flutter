import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;

class FakeConnectionStateProvider implements IConnectionStateProvider {
  const FakeConnectionStateProvider({this.unstable = false});

  final bool unstable;

  @override
  Stream<td.ConnectionState> get connectionStateAsStream {
    if (unstable) {
      return _unstableStream();
    }
    return Stream<td.ConnectionState>.value(const td.ConnectionStateReady());
  }

  RepeatStream<td.ConnectionState> _unstableStream() {
    return RepeatStream<td.ConnectionState>(
      (int _) async* {
        yield const td.ConnectionStateWaitingForNetwork();
        await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
        yield const td.ConnectionStateConnecting();
        await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
        yield const td.ConnectionStateUpdating();
        await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
        yield const td.ConnectionStateReady();
        await Future<dynamic>.delayed(const Duration(milliseconds: 2000));
      },
      1000,
    );
  }
}
