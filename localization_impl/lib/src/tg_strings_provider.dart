import 'package:localization_api/localization_api.dart';

class TgStringsProvider implements IStringsProvider {
  TgStringsProvider(this._stringGetter, this._stringFormattedGetter);

  final String Function(String key) _stringGetter;

  final String Function(String key, List<dynamic> args) _stringFormattedGetter;

  @override
  String get telegramFeatures => _get('TelegramFeatures');

  @override
  String get privacySettings => _get('PrivacySettings');

  @override
  String get notificationsAndSounds => _get('NotificationsAndSounds');

  @override
  String get dataSettings => _get('DataSettings');

  @override
  String get chatSettings => _get('ChatSettings');

  @override
  String get chatBackground => _get('ChatBackground');

  @override
  String get settings => _get('Settings');

  @override
  String get settingsHelp => _get('SettingsHelp');

  @override
  String get askAQuestion => _get('AskAQuestion');

  @override
  String get telegramFAQ => _get('TelegramFAQ');

  @override
  String get privacyPolicy => _get('PrivacyPolicy');

  @override
  String get setProfilePhoto => _get('SetProfilePhoto');

  @override
  String get account => _get('Account');

  @override
  String get tapToChangePhone => _get('TapToChangePhone');

  @override
  String get username => _get('Username');

  @override
  String get userBio => _get('UserBio');

  @override
  String get userBioDetail => _get('UserBioDetail');

  @override
  String get stickersAndMasks => _get('StickersAndMasks');

  @override
  String get suggestStickers => _get('SuggestStickers');

  @override
  String get loopAnimatedStickers => _get('LoopAnimatedStickers');

  @override
  String get loopAnimatedStickersInfo => _get('LoopAnimatedStickersInfo');

  @override
  String get featuredStickers => _get('FeaturedStickers');

  @override
  String get masks => _get('Masks');

  @override
  String get stickersBotInfo => _get('StickersBotInfo');

  @override
  String get suggestStickersAll => _get('SuggestStickersAll');

  @override
  String get suggestStickersInstalled => _get('SuggestStickersInstalled');

  @override
  String get suggestStickersNone => _get('SuggestStickersNone');

  @override
  String get archivedStickers => _get('ArchivedStickers');

  @override
  String get autoNightTheme => _get('AutoNightTheme');

  @override
  String get chromeCustomTabs => _get('ChromeCustomTabs');

  @override
  String get directShare => _get('DirectShare');

  @override
  String get chromeCustomTabsInfo => _get('ChromeCustomTabsInfo');

  @override
  String get directShareInfo => _get('DirectShareInfo');

  @override
  String get enableAnimations => _get('EnableAnimations');

  @override
  String get largeEmoji => _get('LargeEmoji');

  @override
  String get raiseToSpeak => _get('RaiseToSpeak');

  @override
  String get sendByEnter => _get('SendByEnter');

  @override
  String get saveToGallerySettings => _get('SaveToGallerySettings');

  @override
  String get distanceUnits => _get('DistanceUnits');

  @override
  String get distanceUnitsAutomatic => _get('DistanceUnitsAutomatic');

  @override
  String get changeChatBackground => _get('ChangeChatBackground');

  @override
  String actionCreateGroup(List<dynamic> args) =>
      _getFormatted('ActionCreateGroup', args);

  @override
  String get callMessageIncomingMissed => _get('CallMessageIncomingMissed');

  @override
  String get callMessageIncomingDeclined => _get('CallMessageIncomingDeclined');

  @override
  String get callMessageIncoming => _get('CallMessageIncoming');

  @override
  String get callMessageOutgoing => _get('CallMessageOutgoing');

  @override
  String get callMessageOutgoingMissed => _get('CallMessageOutgoingMissed');

  @override
  String eventLogGroupJoined(List<dynamic> args) =>
      _getFormatted('EventLogGroupJoined', args);

  @override
  String actionChangedPhoto(List<dynamic> args) =>
      _getFormatted('ActionChangedPhoto', args);

  @override
  String actionMigrateFromGroupNotify(List<dynamic> args) =>
      _getFormatted('ActionMigrateFromGroupNotify', args);

  @override
  String actionChangedTitle(List<dynamic> args) =>
      _getFormatted('ActionChangedTitle', args);

  @override
  String actionKickUser(List<dynamic> args) =>
      _getFormatted('ActionKickUser', args);

  @override
  String actionRemovedPhoto(List<dynamic> args) =>
      _getFormatted('ActionRemovedPhoto', args);

  @override
  String actionInviteUser(List<dynamic> args) =>
      _getFormatted('ActionInviteUser', args);

  @override
  String messageLifetimeChanged(List<dynamic> args) =>
      _getFormatted('MessageLifetimeChanged', args);

  @override
  String messageLifetimeChangedOutgoing(List<dynamic> args) =>
      _getFormatted('MessageLifetimeChangedOutgoing', args);

  @override
  String get actionMigrateFromGroup => _get('ActionMigrateFromGroup');

  @override
  String get contactJoined => _get('ContactJoined');

  @override
  String get viewContact => _get('ViewContact');

  @override
  String get editedMessage => _get('EditedMessage');

  @override
  String get hiddenName => _get('HiddenName');

  @override
  String get aLongTimeAgo => _get('ALongTimeAgo');

  @override
  String get bot => _get('Bot');

  @override
  String get online => _get('Online');

  @override
  String onlineCount(List<dynamic> args) => _getFormatted('OnlineCount', args);

  @override
  String get lately => _get('Lately');

  @override
  String get withinAWeek => _get('WithinAWeek');

  @override
  String get withinAMonth => _get('WithinAMonth');

  @override
  String members(List<dynamic> args) => _getFormatted('Members', args);

  @override
  String get info => _get('Info');

  @override
  String get notifications => _get('Notifications');

  @override
  String get notificationsOff => _get('NotificationsOff');

  @override
  String get notificationsOn => _get('NotificationsOn');

  @override
  String get sharedLinks => _get('SharedLinks');

  @override
  String get notificationsTurnOn => _get('NotificationsTurnOn');

  @override
  String get notificationsTurnOff => _get('NotificationsTurnOff');

  @override
  String get notificationsCustomize => _get('NotificationsCustomize');

  @override
  String get sentAppCodeTitle => _get('SentAppCodeTitle');

  @override
  String get sentAppCode => _get('SentAppCode');

  @override
  String get didNotGetTheCodeSms => _get('DidNotGetTheCodeSms');

  @override
  String get chooseCountry => _get('ChooseCountry');

  @override
  String get yourPhone => _get('YourPhone');

  @override
  String get stopVerification => _get('StopVerification');

  @override
  String get appName => _get('AppName');

  @override
  String get stop => _get('Stop');

  @override
  String get continue$ => _get('Continue');

  @override
  String get wrongCountry => _get('WrongCountry');

  @override
  String get oK => _get('OK');

  @override
  String get startText => _get('StartText');

  @override
  String get logOutTitle => _get('LogOutTitle');

  @override
  String get alternativeOptions => _get('AlternativeOptions');

  @override
  String get addAnotherAccount => _get('AddAnotherAccount');

  @override
  String get addAnotherAccountInfo => _get('AddAnotherAccountInfo');

  @override
  String get setPasscode => _get('SetPasscode');

  @override
  String get setPasscodeInfo => _get('SetPasscodeInfo');

  @override
  String get clearCache => _get('ClearCache');

  @override
  String get clearCacheInfo => _get('ClearCacheInfo');

  @override
  String get changePhoneNumber => _get('ChangePhoneNumber');

  @override
  String get changePhoneNumberInfo => _get('ChangePhoneNumberInfo');

  @override
  String get contactSupport => _get('ContactSupport');

  @override
  String get contactSupportInfo => _get('ContactSupportInfo');

  @override
  String get logOutInfo => _get('LogOutInfo');

  @override
  String get askAQuestionInfo => _get('AskAQuestionInfo');

  @override
  String get cancel => _get('Cancel');

  @override
  String get askButton => _get('AskButton');

  @override
  String get areYouSureLogout => _get('AreYouSureLogout');

  @override
  String get selectFromGallery => _get('SelectFromGallery');

  @override
  String get setColor => _get('SetColor');

  @override
  String get resetChatBackgrounds => _get('ResetChatBackgrounds');

  @override
  String get resetChatBackgroundsInfo => _get('ResetChatBackgroundsInfo');

  @override
  String get leaveMegaMenu => _get('LeaveMegaMenu');

  @override
  String get leaveChannelMenu => _get('LeaveChannelMenu');

  @override
  String megaLeaveAlertWithName(List<dynamic> args) =>
      _getFormatted('MegaLeaveAlertWithName', args);

  @override
  String channelLeaveAlertWithName(List<dynamic> args) =>
      _getFormatted('ChannelLeaveAlertWithName', args);

  @override
  String get filters => _get('Filters');

  @override
  String get createNewFilter => _get('CreateNewFilter');

  @override
  String get filterNew => _get('FilterNew');

  @override
  String get channelUnmute => _get('ChannelUnmute');

  @override
  String get channelMute => _get('ChannelMute');

  @override
  String get channelJoin => _get('ChannelJoin');

  @override
  String get devices => _get('Devices');

  @override
  String get currentSession => _get('CurrentSession');

  @override
  String get terminateAllSessions => _get('TerminateAllSessions');

  @override
  String get clearOtherSessionsHelp => _get('ClearOtherSessionsHelp');

  @override
  String get authAnotherClient => _get('AuthAnotherClient');

  @override
  String get otherSessions => _get('OtherSessions');

  @override
  String get terminateSessionInfo => _get('TerminateSessionInfo');

  @override
  String get newGroup => _get('NewGroup');

  @override
  String get newSecretChat => _get('NewSecretChat');

  @override
  String get newChannel => _get('NewChannel');

  @override
  String get filterDeleteAlert => _get('FilterDeleteAlert');

  @override
  String get filterDelete => _get('FilterDelete');

  @override
  String get delete => _get('Delete');

  @override
  String get editName => _get('EditName');

  @override
  String get notificationsPrivateChats => _get('NotificationsPrivateChats');

  @override
  String get notificationsGroups => _get('NotificationsGroups');

  @override
  String get notificationsChannels => _get('NotificationsChannels');

  @override
  String get voipNotificationSettings => _get('VoipNotificationSettings');

  @override
  String get badgeNumber => _get('BadgeNumber');

  @override
  String get inAppNotifications => _get('InAppNotifications');

  @override
  String get pinnedMessages => _get('PinnedMessages');

  @override
  String get resetAllNotifications => _get('ResetAllNotifications');

  @override
  String get blockedUsers => _get('BlockedUsers');

  @override
  String get privacyPhone => _get('PrivacyPhone');

  @override
  String get privacyLastSeen => _get('PrivacyLastSeen');

  @override
  String get privacyProfilePhoto => _get('PrivacyProfilePhoto');

  @override
  String get privacyForwards => _get('PrivacyForwards');

  @override
  String get privacyP2P => _get('PrivacyP2P');

  @override
  String get groupsAndChannels => _get('GroupsAndChannels');

  @override
  String get passcode => _get('Passcode');

  @override
  String get twoStepVerification => _get('TwoStepVerification');

  @override
  String get sessionsTitle => _get('SessionsTitle');

  @override
  String get deleteAccountIfAwayFor2 => _get('DeleteAccountIfAwayFor2');

  @override
  String get privacyPaymentsClear => _get('PrivacyPaymentsClear');

  @override
  String get webSessionsTitle => _get('WebSessionsTitle');

  @override
  String get syncContactsDelete => _get('SyncContactsDelete');

  @override
  String get syncContacts => _get('SyncContacts');

  @override
  String get suggestContacts => _get('SuggestContacts');

  @override
  String get mapPreviewProvider => _get('MapPreviewProvider');

  @override
  String get secretWebPage => _get('SecretWebPage');

  @override
  String get contacts => _get('Contacts');

  @override
  String get inviteFriends => _get('InviteFriends');

  @override
  String get addPeopleNearby => _get('AddPeopleNearby');

  @override
  String get addContactTitle => _get('AddContactTitle');

  @override
  String get channelEdit => _get('ChannelEdit');

  @override
  String get areYouSureDeleteAndExit => _get('AreYouSureDeleteAndExit');

  @override
  String get deleteMega => _get('DeleteMega');

  @override
  String get deleteAndExit => _get('DeleteAndExit');

  @override
  String get channelDelete => _get('ChannelDelete');

  @override
  String get deleteAndExitButton => _get('DeleteAndExitButton');

  @override
  String get enterChannelName => _get('EnterChannelName');

  @override
  String get descriptionInfo => _get('DescriptionInfo');

  @override
  String get descriptionPlaceholder => _get('DescriptionPlaceholder');

  @override
  String get addToContacts => _get('AddToContacts');

  @override
  String get blockContact => _get('BlockContact');

  @override
  String get newContact => _get('NewContact');

  @override
  String get firstName => _get('FirstName');

  @override
  String get lastName => _get('LastName');

  @override
  String mobileHiddenExceptionInfo(List<dynamic> args) =>
      _getFormatted('MobileHiddenExceptionInfo', args);

  @override
  String sharePhoneNumberWith(List<dynamic> args) =>
      _getFormatted('SharePhoneNumberWith', args);

  @override
  String get mobileHidden => _get('MobileHidden');

  @override
  String get done => _get('Done');

  @override
  String get usernameInvalid => _get('UsernameInvalid');

  @override
  String get usernameInUse => _get('UsernameInUse');

  @override
  String get usernameInvalidShort => _get('UsernameInvalidShort');

  @override
  String get usernameInvalidLong => _get('UsernameInvalidLong');

  @override
  String get usernameInvalidStartNumber => _get('UsernameInvalidStartNumber');

  @override
  String get usernameChecking => _get('UsernameChecking');

  @override
  String get usernameHelp => _get('UsernameHelp');

  @override
  String usernameHelpLink(List<dynamic> args) =>
      _getFormatted('UsernameHelpLink', args);

  @override
  String usernameAvailable(List<dynamic> args) =>
      _getFormatted('UsernameAvailable', args);

  @override
  String get usernamePlaceholder => _get('UsernamePlaceholder');

  @override
  String get usernameEmpty => _get('UsernameEmpty');

  String _get(String key) => _stringGetter.call(key);

  String _getFormatted(String key, List<dynamic> args) =>
      _stringFormattedGetter.call(key, args);
}
