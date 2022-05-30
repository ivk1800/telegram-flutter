import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:contacts_manager_api/contacts_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_file_api/feature_file_api.dart';
import 'package:localization_api/localization_api.dart';

import 'screen/new_contact/new_contact_router.dart';

class NewContactFeatureDependencies {
  NewContactFeatureDependencies({
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.router,
    required this.blockInteractionManager,
    required this.fileDownloader,
    required this.userRepository,
    required this.contactsManager,
    required this.errorTransformer,
  });

  final IConnectionStateProvider connectionStateProvider;
  final IStringsProvider stringsProvider;
  final INewContactRouter router;
  final IBlockInteractionManager blockInteractionManager;
  final IFileDownloader fileDownloader;
  final IUserRepository userRepository;
  final IContactsManager contactsManager;
  final IErrorTransformer errorTransformer;
}
