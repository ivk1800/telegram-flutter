import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:core_tdlib_impl/src/data_source/data_source.dart';
import 'package:td_api/td_api.dart' as td;

class StickerRepositoryImpl implements IStickerRepository {
  StickerRepositoryImpl({
    required StickerDataSource dataSource,
  }) : _dataSource = dataSource;

  final StickerDataSource _dataSource;

  @override
  Future<List<td.StickerSetInfo>> getInstalledStickers() {
    return _dataSource.getInstalledStickers();
  }
}
