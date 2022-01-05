import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

// todo provide more information for mac nad windows
class DeviceInfoProvider {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> get systemVersion async {
    if (Platform.isAndroid) {
      final AndroidBuildVersion version =
          (await _deviceInfoPlugin.androidInfo).version;
      return 'Android ${version.release} (SDK ${version.sdkInt})';
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return '${iosInfo.systemName} ${iosInfo.systemVersion}';
    } else if (Platform.isMacOS) {
      return '';
    } else if (Platform.isWindows) {
      return '';
    }

    return '';
  }

  Future<String> get deviceModel async {
    if (Platform.isAndroid) {
      return (await _deviceInfoPlugin.androidInfo).model!;
    } else if (Platform.isIOS) {
      return (await _deviceInfoPlugin.iosInfo).model!;
    } else if (Platform.isMacOS) {
      return 'unknown model';
    } else if (Platform.isWindows) {
      return 'unknown model';
    }
    return 'unknown';
  }

  Future<String> get systemLanguageCode async => 'en';
}
