import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';
import 'package:td_api/td_api.dart' as td;
import 'dev_initializer.dart';
import 'td_lib_initializer.dart';

class AppInitializer {
  @j.inject
  AppInitializer({
    required TdLibInitializer tdLibInitializer,
    required ILocalizationManager localizationManager,
    required DevInitializer devInitializer,
    required ITdFunctionExecutor functionExecutor,
  })  : _tdLibInitializer = tdLibInitializer,
        _localizationManager = localizationManager,
        _devInitializer = devInitializer,
        _functionExecutor = functionExecutor;

  final TdLibInitializer _tdLibInitializer;
  final ILocalizationManager _localizationManager;
  final DevInitializer _devInitializer;
  final ITdFunctionExecutor _functionExecutor;

  Future<void> init() async {
    await _localizationManager.init('en', 'en');
    await _devInitializer.init();
    await _tdLibInitializer.init();

    _functionExecutor.execute<td.TdObject>(
      const td.SetLogVerbosityLevel(newVerbosityLevel: 0),
    );
  }
}
