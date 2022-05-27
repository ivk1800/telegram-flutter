import 'dart:async';
import 'package:core_arch/core_arch.dart';
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/profile_feature_router.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_args.dart';
import 'package:feature_shared_media_api/feature_shared_media_api.dart';
import 'package:rxdart/rxdart.dart';

import 'header_action_data.dart';
import 'header_actions_resolver.dart';
import 'profile_state.dart';

class ProfileViewModel extends BaseViewModel {
  ProfileViewModel({
    required ProfileArgs args,
    required IProfileFeatureRouter router,
    required IChatHeaderInfoInteractor headerInfoInteractor,
    required ContentInteractor contentInteractor,
    required HeaderActionsResolver headerActionsResolver,
  })  : _contentInteractor = contentInteractor,
        _headerActionsResolver = headerActionsResolver,
        _args = args,
        _router = router,
        _headerInfoInteractor = headerInfoInteractor {
    _initCompositeStateSubscription();
  }

  final ContentInteractor _contentInteractor;
  final IProfileFeatureRouter _router;
  final IChatHeaderInfoInteractor _headerInfoInteractor;
  final ProfileArgs _args;
  final HeaderActionsResolver _headerActionsResolver;

  final BehaviorSubject<ProfileState> _stateSubject =
      BehaviorSubject<ProfileState>.seeded(
    const ProfileState(
      bodyState: BodyState.loading(),
      headerState: HeaderState.loading(),
    ),
  );

  Stream<ProfileState> get state => _stateSubject;

  @override
  void dispose() {
    _stateSubject.close();
    return super.dispose();
  }

  void onNotificationToggleTap() {
    if (!_stateSubject.hasValue) {
      return;
    }

    final BodyState state = _stateSubject.value.bodyState;
    if (state is BodyData) {
      _stateSubject.add(
        _stateSubject.value.copyWith(
          bodyState: state.copyWith(
            content: state.content.copy(
              isMuted: !state.content.isMuted,
            ),
          ),
        ),
      );
    }
  }

  void onNotificationTap() {
    _router.toQuickNotificationSettings();
  }

  void onMessagesTap(SharedContentType type) {
    _router.toSharedMedia(type);
  }

  void onHeaderActionTap(HeaderAction action) {
    switch (action) {
      case HeaderAction.edit:
        _router.toChatAdministration(_args.id);
        break;
      case HeaderAction.addToContacts:
        _router.toAddNewContact(_args.id);
        break;
    }
  }

  void _initCompositeStateSubscription() {
    final Stream<BodyState> body =
        Stream<ContentData>.fromFuture(_contentInteractor.getContent())
            .map<BodyState>(BodyState.data)
            .startWith(const BodyState.loading());

    final Stream<ChatHeaderInfo> info = _headerInfoInteractor.infoStream
        .startWith(_headerInfoInteractor.current);

    final Stream<HeaderState> header = Rx.zip2(
      info,
      _headerActionsResolver.resolveActions(id: _args.id, type: _args.type),
      (ChatHeaderInfo info, List<HeaderActionData> actions) {
        return HeaderState.info(info, actions);
      },
    );

    final Stream<ProfileState> profileStateStream =
        Rx.combineLatest2<BodyState, HeaderState, ProfileState>(
      body,
      header,
      (BodyState body, HeaderState header) =>
          ProfileState(headerState: header, bodyState: body),
    );

    subscribe<ProfileState>(profileStateStream, _stateSubject.add);
  }
}
