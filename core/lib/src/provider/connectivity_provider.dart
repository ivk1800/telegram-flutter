abstract class IConnectivityProvider {
  ConnectivityStatus get status;

  Stream<ConnectivityStatus> get onStatusChange;
}

enum ConnectivityStatus { wifi, mobile, none }
