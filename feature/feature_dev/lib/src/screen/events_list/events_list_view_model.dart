import 'package:core_arch/core_arch.dart';
import 'package:feature_dev/src/events_repository.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:td_api/td_api.dart' as td;

@j.singleton
@j.disposable
class EventsListVieModel extends BaseViewModel {
  @j.inject
  EventsListVieModel({
    required EventsRepository eventsRepository,
  }) : _eventsRepository = eventsRepository;

  final EventsRepository _eventsRepository;

  Stream<List<td.TdObject>> get events => _eventsRepository.events;
}
