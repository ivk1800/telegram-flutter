import 'package:feature_settings_search_impl/src/domain/search_group.dart';
import 'package:feature_settings_search_impl/src/domain/search_item.dart';
import 'package:feature_settings_search_impl/src/domain/search_item_data.dart';
import 'package:localization_api/localization_api.dart';

class SearchRepository {
  SearchRepository({
    required ILocalizationManager localizationManager,
  }) : _localizationManager = localizationManager;

  final ILocalizationManager _localizationManager;

  late final Future<List<SearchItemData>> _cache = _createAllItems();

  Future<List<SearchItemData>> find(String query) async {
    final List<String> queryParts = query.split(' ');

    final List<SearchItemData> all = await _cache;
    return all
        .where((SearchItemData item) => queryParts
            .every((String part) => item.name.toLowerCase().contains(part)))
        .toList();
  }

  Future<List<SearchItemData>> _createAllItems() {
    return Future<List<SearchItemData>>.value(
      <SearchItemData>[
        SearchItemData(
          group: SearchGroup.profile,
          item: SearchItem.editName,
          name: _getString('EditName'),
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.profile,
          item: SearchItem.changePhoneNumber,
          name: _getString('ChangePhoneNumber'),
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.profile,
          item: SearchItem.addAnotherAccount,
          name: _getString('AddAnotherAccount'),
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.profile,
          item: SearchItem.userBio,
          name: _getString('UserBio'),
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.notificationsAndSounds,
          name: _getString('NotificationsAndSounds'),
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.notificationsPrivateChats,
          name: _getString('NotificationsPrivateChats'),
          paths: <String>[_getString('NotificationsAndSounds')],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.notificationsGroups,
          name: _getString('NotificationsGroups'),
          paths: <String>[_getString('NotificationsAndSounds')],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.notificationsChannels,
          name: _getString('NotificationsChannels'),
          paths: <String>[_getString('NotificationsAndSounds')],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.voipNotificationSettings,
          name: _getString('VoipNotificationSettings'),
          paths: <String>[_getString('NotificationsAndSounds')],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.badgeNumber,
          name: _getString('BadgeNumber'),
          paths: <String>[_getString('NotificationsAndSounds')],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.inAppNotifications,
          name: _getString('InAppNotifications'),
          paths: <String>[_getString('InAppNotifications')],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.contactJoined,
          name: _getString('ContactJoined'),
          paths: <String>[_getString('NotificationsAndSounds')],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.pinnedMessages,
          name: _getString('PinnedMessages'),
          paths: <String>[_getString('NotificationsAndSounds')],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.resetAllNotifications,
          name: _getString('ResetAllNotifications'),
          paths: <String>[_getString('NotificationsAndSounds')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacySettings,
          name: _getString('PrivacySettings'),
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.blockedUsers,
          name: _getString('BlockedUsers'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyPhone,
          name: _getString('PrivacyPhone'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyLastSeen,
          name: _getString('PrivacyLastSeen'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyProfilePhoto,
          name: _getString('PrivacyProfilePhoto'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyForwards,
          name: _getString('PrivacyForwards'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyP2P,
          name: _getString('PrivacyP2P'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.calls,
          name: _getString('Calls'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.groupsAndChannels,
          name: _getString('GroupsAndChannels'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.passcode,
          name: _getString('Passcode'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.twoStepVerification,
          name: _getString('TwoStepVerification'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.sessionsTitle,
          name: _getString('SessionsTitle'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.deleteAccountIfAwayFor2,
          name: _getString('DeleteAccountIfAwayFor2'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyPaymentsClear,
          name: _getString('PrivacyPaymentsClear'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.webSessionsTitle,
          name: _getString('WebSessionsTitle'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.syncContactsDelete,
          name: _getString('SyncContactsDelete'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.syncContacts,
          name: _getString('SyncContacts'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.suggestContacts,
          name: _getString('SuggestContacts'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.mapPreviewProvider,
          name: _getString('MapPreviewProvider'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.secretWebPage,
          name: _getString('SecretWebPage'),
          paths: <String>[_getString('PrivacySettings')],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.devices,
          name: _getString('Devices'),
          paths: <String>[_getString('PrivacySettings')],
        ),
      ],
    );
  }

  String _getString(String key) => _localizationManager.getString(key);
}
