import 'package:core/core.dart';
import 'package:td_api/td_api.dart' as td;

extension ConnectivityStatusExtensions on ConnectivityStatus {
  td.NetworkType toNetworkType() {
    switch (this) {
      case ConnectivityStatus.wifi:
        return const td.NetworkTypeWiFi();
      case ConnectivityStatus.mobile:
        return const td.NetworkTypeMobile();
      case ConnectivityStatus.none:
        return const td.NetworkTypeNone();
      case ConnectivityStatus.other:
        return const td.NetworkTypeOther();
    }
  }
}
