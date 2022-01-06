import 'package:connectivity/connectivity.dart' as c;
import 'package:core/core.dart';
import 'package:rxdart/rxdart.dart';

import 'connectivity_provider.dart';

class ConnectivityProviderImpl implements IConnectivityProvider {
  ConnectivityProviderImpl() {
    final c.Connectivity connectivity = c.Connectivity();
    connectivity.onConnectivityChanged.listen((c.ConnectivityResult event) {
      final ConnectivityStatus connectivityStatus =
          event.toConnectivityStatus();
      _onStatusChangeSubject.add(connectivityStatus);
      _currentStatus = connectivityStatus;
    });

    connectivity.checkConnectivity().then((c.ConnectivityResult value) {
      _onStatusChangeSubject.add(value.toConnectivityStatus());
      return value;
    });
  }

  final PublishSubject<ConnectivityStatus> _onStatusChangeSubject =
      PublishSubject<ConnectivityStatus>();

  ConnectivityStatus _currentStatus = ConnectivityStatus.none;

  @override
  Stream<ConnectivityStatus> get onStatusChange => _onStatusChangeSubject;

  @override
  ConnectivityStatus get status => _currentStatus;
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
    }
  }
}
