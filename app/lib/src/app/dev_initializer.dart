import 'package:feature_dev/feature_dev.dart';
import 'package:jugger/jugger.dart' as j;

class DevInitializer {
  @j.inject
  DevInitializer({required j.ILazy<DevFeature> devFeature})
      : _devFeature = devFeature;

  final j.ILazy<DevFeature> _devFeature;

  Future<void> init() async {
    _devFeature.value.init();
  }
}
