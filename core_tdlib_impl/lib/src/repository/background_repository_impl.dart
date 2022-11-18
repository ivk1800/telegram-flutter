import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:td_api/td_api.dart' as td;

class BackgroundRepositoryImpl implements IBackgroundRepository {
  BackgroundRepositoryImpl({
    required BackgroundDataSource dataSource,
  }) : _dataSource = dataSource;

  final BackgroundDataSource _dataSource;

  @override
  Future<List<td.Background>> get backgrounds => _dataSource.backgrounds;

  @override
  Future<td.Background> getBackground(int id) => _dataSource.getBackground(id);
}
