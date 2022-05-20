import 'package:feature_settings_search_impl/src/domain/search_group.dart';
import 'package:feature_settings_search_impl/src/domain/search_item.dart';
import 'package:feature_settings_search_impl/src/domain/search_item_data.dart';
import 'package:localization_api/localization_api.dart';

class SearchRepository {
  SearchRepository({
    required IStringsProvider stringsProvider,
  }) : _stringsProvider = stringsProvider;

  final IStringsProvider _stringsProvider;

  late final Future<List<SearchItemData>> _cache = _createAllItems();

  Future<List<SearchItemData>> find(String query) async {
    final List<String> queryParts = query.split(' ');

    final List<SearchItemData> all = await _cache;
    return all
        .where(
          (SearchItemData item) => queryParts
              .every((String part) => item.name.toLowerCase().contains(part)),
        )
        .toList();
  }

  Future<List<SearchItemData>> _createAllItems() {
    return Future<List<SearchItemData>>.value(
      <SearchItemData>[
        SearchItemData(
          group: SearchGroup.profile,
          item: SearchItem.editName,
          name: _stringsProvider.editName,
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.profile,
          item: SearchItem.changePhoneNumber,
          name: _stringsProvider.changePhoneNumber,
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.profile,
          item: SearchItem.addAnotherAccount,
          name: _stringsProvider.addAnotherAccount,
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.profile,
          item: SearchItem.userBio,
          name: _stringsProvider.userBio,
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.notificationsAndSounds,
          name: _stringsProvider.notificationsAndSounds,
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.notificationsPrivateChats,
          name: _stringsProvider.notificationsPrivateChats,
          paths: <String>[_stringsProvider.notificationsAndSounds],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.notificationsGroups,
          name: _stringsProvider.notificationsGroups,
          paths: <String>[_stringsProvider.notificationsAndSounds],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.notificationsChannels,
          name: _stringsProvider.notificationsChannels,
          paths: <String>[_stringsProvider.notificationsAndSounds],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.voipNotificationSettings,
          name: _stringsProvider.voipNotificationSettings,
          paths: <String>[_stringsProvider.notificationsAndSounds],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.badgeNumber,
          name: _stringsProvider.badgeNumber,
          paths: <String>[_stringsProvider.notificationsAndSounds],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.inAppNotifications,
          name: _stringsProvider.inAppNotifications,
          paths: <String>[_stringsProvider.inAppNotifications],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.contactJoined,
          name: _stringsProvider.contactJoined,
          paths: <String>[_stringsProvider.notificationsAndSounds],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.pinnedMessages,
          name: _stringsProvider.pinnedMessages,
          paths: <String>[_stringsProvider.notificationsAndSounds],
        ),
        SearchItemData(
          group: SearchGroup.notifications,
          item: SearchItem.resetAllNotifications,
          name: _stringsProvider.resetAllNotifications,
          paths: <String>[_stringsProvider.notificationsAndSounds],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacySettings,
          name: _stringsProvider.privacySettings,
          paths: <String>[],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.blockedUsers,
          name: _stringsProvider.blockedUsers,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyPhone,
          name: _stringsProvider.privacyPhone,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyLastSeen,
          name: _stringsProvider.privacyLastSeen,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyProfilePhoto,
          name: _stringsProvider.privacyProfilePhoto,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyForwards,
          name: _stringsProvider.privacyForwards,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyP2P,
          name: _stringsProvider.privacyP2P,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.calls,
          name: _stringsProvider.voipNotificationSettings,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.groupsAndChannels,
          name: _stringsProvider.groupsAndChannels,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.passcode,
          name: _stringsProvider.passcode,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.twoStepVerification,
          name: _stringsProvider.twoStepVerification,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.sessionsTitle,
          name: _stringsProvider.sessionsTitle,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.deleteAccountIfAwayFor2,
          name: _stringsProvider.deleteAccountIfAwayFor2,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.privacyPaymentsClear,
          name: _stringsProvider.privacyPaymentsClear,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.webSessionsTitle,
          name: _stringsProvider.webSessionsTitle,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.syncContactsDelete,
          name: _stringsProvider.syncContactsDelete,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.syncContacts,
          name: _stringsProvider.syncContacts,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.suggestContacts,
          name: _stringsProvider.suggestContacts,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.mapPreviewProvider,
          name: _stringsProvider.mapPreviewProvider,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.secretWebPage,
          name: _stringsProvider.secretWebPage,
          paths: <String>[_stringsProvider.privacySettings],
        ),
        SearchItemData(
          group: SearchGroup.privacy,
          item: SearchItem.devices,
          name: _stringsProvider.devices,
          paths: <String>[_stringsProvider.privacySettings],
        ),
      ],
    );
  }
}
