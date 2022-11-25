import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:td_api/td_api.dart' as td;

class FakeBasicGroupRepository implements IBasicGroupRepository {
  const FakeBasicGroupRepository();

  @override
  Future<td.BasicGroup> getGroup(int id) {
    return Completer<td.BasicGroup>().future;
  }

  @override
  Future<td.BasicGroupFullInfo> getGroupFullInfo(int id) {
    return Completer<td.BasicGroupFullInfo>().future;
  }
}
