import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeBackgroundRepository implements IBackgroundRepository {
  const FakeBackgroundRepository({required this.fakeBackgrounds});

  final Future<List<td.Background>> Function() fakeBackgrounds;

  @override
  Future<List<td.Background>> get backgrounds => fakeBackgrounds.call();

  @override
  Future<td.Background> getBackground(int id) {
    return fakeBackgrounds.call().then(
          (List<td.Background> value) =>
              value.firstWhere((td.Background element) => element.id == id),
        );
  }
}
