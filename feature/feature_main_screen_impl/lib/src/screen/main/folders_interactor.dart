import 'package:core_arch/core_arch.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:td_api/td_api.dart' as td;
import 'folder.dart';

class FoldersInteractor with SubscriptionMixin {
  FoldersInteractor({
    required IChatFilterRepository chatFilterRepository,
  }) : _chatFilterRepository = chatFilterRepository {
    subscribe<List<Folder>>(
      _chatFilterRepository.chatFiltersStream
          .map(
            (List<td.ChatFilterInfo> event) =>
                event.map((td.ChatFilterInfo info) {
              return Folder.id(id: info.id, title: info.title);
            }).toList(growable: false),
          )
          .map(
            (List<Folder> folders) => <Folder>[
              const Folder.main(),
              ...folders,
            ],
          ),
      _foldersSubject.add,
    );
  }

  final IChatFilterRepository _chatFilterRepository;

  final BehaviorSubject<List<Folder>> _foldersSubject =
      BehaviorSubject<List<Folder>>();

  Stream<List<Folder>> get foldersStream => _foldersSubject;

  @override
  void dispose() {
    _foldersSubject.close();
    super.dispose();
  }
}
