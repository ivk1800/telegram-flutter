import 'package:tdlib/td_api.dart' as td;
import 'package:core/core.dart';

extension ConnectivityStatusExtensions on ConnectivityStatus {
  td.NetworkType toNetworkType() {
    switch (this) {
      case ConnectivityStatus.wifi:
        return const td.NetworkTypeWiFi();
      case ConnectivityStatus.mobile:
        return const td.NetworkTypeMobile();
      case ConnectivityStatus.none:
        return const td.NetworkTypeNone();
    }
  }
}
