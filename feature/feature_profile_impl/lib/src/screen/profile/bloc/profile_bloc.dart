import 'dart:async';

import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/profile_feature_router.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'profile_event.dart';
import 'profile_state.dart';
import 'profile_state_ext.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required ProfileArgs args,
    required IProfileFeatureRouter router,
    required IChatHeaderInfoInteractor headerInfoInteractor,
    required ContentInteractor contentInteractor,
    required IChatMessageRepository messageRepository,
  })  : _args = args,
        _contentInteractor = contentInteractor,
        _router = router,
        _headerInfoInteractor = headerInfoInteractor,
        _messageRepository = messageRepository,
        super(ProfileState(
          headerState: HeaderState(
            info: ChatHeaderInfo(
              photoId: 0,
              title: 'title',
              chatId: args.id,
              subtitle: 'subtitle',
            ),
          ),
          bodyState: const LoadingBodyState(),
        )) {
    _initCompositeStateSubscription();
  }

  final ProfileArgs _args;
  final IChatMessageRepository _messageRepository;
  final ContentInteractor _contentInteractor;
  final IProfileFeatureRouter _router;
  final IChatHeaderInfoInteractor _headerInfoInteractor;
  StreamSubscription<dynamic>? _compositeStateSubscription;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ActionEvent) {
      _handleActionEvent(event);
      return;
    }
  }

  void _handleActionEvent(ActionEvent event) {
    switch (event.runtimeType) {
      case NotificationTap:
        _router.toQuickNotificationSettings();
        return;
      case NotificationToggleTap:
        final DataBodyState bodyState = state.bodyState as DataBodyState;
        emit(
          state.copy(
            bodyState: bodyState.copy(
              content: bodyState.content.copy(
                isMuted: !bodyState.content.isMuted,
              ),
            ),
          ),
        );
        return;
      case MessagesTap:
        _router.toSharedMedia((event as MessagesTap).type);
        return;
    }
  }

  @override
  Future<void> close() {
    _compositeStateSubscription?.cancel();
    return super.close();
  }

  void _initCompositeStateSubscription() {
    final Stream<BodyState> body =
        Stream<ContentData>.fromFuture(_contentInteractor.getContent())
            .map<BodyState>((ContentData data) => DataBodyState(
                  content: data,
                ))
            .startWith(const LoadingBodyState());

    final Stream<HeaderState> header = _headerInfoInteractor.infoStream
        .startWith(_headerInfoInteractor.current)
        .map((ChatHeaderInfo event) => HeaderState(
              info: event,
            ));

    _compositeStateSubscription =
        Rx.combineLatest2<BodyState, HeaderState, ProfileState>(
      body,
      header,
      (BodyState body, HeaderState header) =>
          ProfileState(headerState: header, bodyState: body),
    ).listen(emit);
  }
}
