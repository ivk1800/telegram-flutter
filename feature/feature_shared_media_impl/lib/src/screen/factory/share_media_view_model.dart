import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:localization_api/localization_api.dart';

@j.disposable
@j.singleton
class SharedMediaViewModel extends BaseViewModel {
  @j.inject
  SharedMediaViewModel({
    required IStringsProvider stringsProvider,
    required IChatMessageRepository chatMessageRepository,
  })  : _stringsProvider = stringsProvider,
        _chatMessageRepository = chatMessageRepository;

  // ignore: unused_field
  final IStringsProvider _stringsProvider;
  // ignore: unused_field
  final IChatMessageRepository _chatMessageRepository;
}
