import 'package:connectivity_plus/connectivity_plus.dart' as c;
import 'package:core/core.dart';
import 'package:rxdart/rxdart.dart';

import 'connectivity_provider.dart';

class ConnectivityProviderImpl implements IConnectivityProvider {
  ConnectivityProviderImpl() {
    final c.Connectivity connectivity = c.Connectivity();
    connectivity.onConnectivityChanged.listen(_dispatchStatus);

    connectivity.checkConnectivity().then((c.ConnectivityResult value) {
      _onStatusChangeSubject.add(value.toConnectivityStatus());
      return value;
    });
  }

  final PublishSubject<ConnectivityStatus> _onStatusChangeSubject =
      PublishSubject<ConnectivityStatus>();

  ConnectivityStatus _currentStatus = ConnectivityStatus.none;

  @override
  Stream<ConnectivityStatus> get onStatusChange =>
      _onStatusChangeSubject.distinct();

  @override
  ConnectivityStatus get status => _currentStatus;

  void _dispatchStatus(c.ConnectivityResult connectivityResult) {
    final ConnectivityStatus status = connectivityResult.toConnectivityStatus();
    _onStatusChangeSubject.add(status);
    _currentStatus = status;
  }
}

extension _ConnectivityExtensions on c.ConnectivityResult {
  ConnectivityStatus toConnectivityStatus() {
    switch (this) {
      case c.ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;
      case c.ConnectivityResult.mobile:
        return ConnectivityStatus.mobile;
      case c.ConnectivityResult.none:
        return ConnectivityStatus.none;
      case c.ConnectivityResult.ethernet:
      case c.ConnectivityResult.bluetooth:
        return ConnectivityStatus.other;
    }
  }
}
