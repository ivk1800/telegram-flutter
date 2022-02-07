import 'dart:async';

import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/profile_feature_router.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileArgs args,
    required IProfileFeatureRouter router,
    required IChatHeaderInfoInteractor headerInfoInteractor,
    required ContentInteractor contentInteractor,
  })  : _contentInteractor = contentInteractor,
        _router = router,
        _headerInfoInteractor = headerInfoInteractor,
        super(
          ProfileState(
            headerState: HeaderState.info(
              ChatHeaderInfo(
                photoId: 0,
                title: 'title',
                chatId: args.id,
                subtitle: 'subtitle',
              ),
            ),
            bodyState: const BodyState.loading(),
          ),
        ) {
    _init();
  }

  final ContentInteractor _contentInteractor;
  final IProfileFeatureRouter _router;
  final IChatHeaderInfoInteractor _headerInfoInteractor;
  StreamSubscription<dynamic>? _compositeStateSubscription;

  @override
  Future<void> close() {
    _compositeStateSubscription?.cancel();
    return super.close();
  }

  void _init() {
    on<NotificationToggleTap>(_onNotificationToggleTap);
    on<NotificationTap>(_onNotificationTap);
    on<MessagesTap>(_onMessagesTap);
    on<Init>(_onInit);
    on<NewProfileState>(_onNewProfileState);
  }

  void _onNotificationToggleTap(
      NotificationToggleTap event, Emitter<ProfileState> emit) {
    final Data bodyState = state.bodyState as Data;

    state.copyWith(
      bodyState: bodyState.copyWith(
          content: bodyState.content.copy(
        isMuted: !bodyState.content.isMuted,
      )),
    );
  }

  void _onNotificationTap(NotificationTap event, Emitter<ProfileState> emit) {
    _router.toQuickNotificationSettings();
  }

  void _onNewProfileState(NewProfileState event, Emitter<ProfileState> emit) {
    emit(event.state);
  }

  void _onMessagesTap(MessagesTap event, Emitter<ProfileState> emit) {
    _router.toSharedMedia(event.type);
  }

  void _onInit(Init event, Emitter<ProfileState> emit) {
    _initCompositeStateSubscription(emit);
  }

  void _initCompositeStateSubscription(Emitter<ProfileState> emit) {
    final Stream<BodyState> body =
        Stream<ContentData>.fromFuture(_contentInteractor.getContent())
            .map<BodyState>((ContentData data) => BodyState.data(data))
            .startWith(const BodyState.loading());

    final Stream<HeaderState> header = _headerInfoInteractor.infoStream
        .startWith(_headerInfoInteractor.current)
        .map((ChatHeaderInfo info) => HeaderState.info(info));

    _compositeStateSubscription =
        Rx.combineLatest2<BodyState, HeaderState, ProfileState>(
      body,
      header,
      (BodyState body, HeaderState header) =>
          ProfileState(headerState: header, bodyState: body),
    ).map((ProfileState s) => ProfileEvent.newProfileState(s)).listen(add);
  }
}
