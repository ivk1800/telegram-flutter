import 'package:core/core.dart';
import 'package:core_arch/core_arch.dart';
import 'package:core_presentation/core_presentation.dart';
import 'package:core_utils/core_utils.dart';
import 'package:feature_main_screen_impl/src/screen/main/header_state.dart';
import 'package:jugger/jugger.dart' as j;
import 'package:rxdart/rxdart.dart';
import 'package:theme_manager_api/theme_manager_api.dart';
import 'package:tuple/tuple.dart';
import 'package:user_info/user_info.dart';

@j.singleton
@j.disposable
class HeaderViewModel extends BaseViewModel {
  @j.inject
  HeaderViewModel({
    required IThemeManager themeManager,
    required UserInfoResolver userInfoResolver,
    required OptionsManager optionsManager,
  })  : _themeManager = themeManager,
        _optionsManager = optionsManager,
        _userInfoResolver = userInfoResolver {
    _init();
  }

  final IThemeManager _themeManager;
  final UserInfoResolver _userInfoResolver;
  final OptionsManager _optionsManager;

  final BehaviorSubject<HeaderState> _stateSubject =
      BehaviorSubject<HeaderState>.seeded(const HeaderState.loading());

  Stream<HeaderState> get state => _stateSubject;

  void onToggleThemeTap() {
    // todo handle more themes
    if (_themeManager.theme == const Theme.classic()) {
      _themeManager.theme = const Theme.dark();
    } else {
      _themeManager.theme = const Theme.classic();
    }
  }

  @override
  void dispose() {
    _stateSubject.close();
    super.dispose();
  }

  void _init() {
    final Stream<UserInfo> userInfoStream = _optionsManager
        .getMyId()
        .asStream()
        .flatMap(_userInfoResolver.resolveAsStream);

    final Stream<HeaderState> flatMap =
        Rx.combineLatest2<UserInfo, Theme, Tuple2<UserInfo, Theme>>(
      userInfoStream,
      _themeManager.themeStream,
      Tuple2<UserInfo, Theme>.new,
    ).map(
      (Tuple2<UserInfo, Theme> data) {
        final UserInfo info = data.item1;

        return HeaderState.data(
          isDarkTheme: data.item2 == const Theme.dark(),
          avatar: Avatar.simple(
            abbreviation: getAvatarAbbreviation(
              first: info.user.firstName,
              second: info.user.lastName,
            ),
            objectId: info.user.id,
            imageFileId: info.user.profilePhoto?.small.id,
          ),
          name: <String>[info.user.firstName, info.user.lastName]
              .where((String element) => element.isNotEmpty)
              .join(' '),
          // todo format
          phoneNumberFormatted: info.user.phoneNumber,
        );
      },
    );

    subscribe<HeaderState>(flatMap, _stateSubject.add);
  }
}
