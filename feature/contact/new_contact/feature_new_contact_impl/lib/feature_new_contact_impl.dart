library feature_new_contact_impl;

import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:contacts_manager_api/contacts_manager_api.dart';
import 'package:core_tdlib_api/core_tdlib_api.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_new_contact_api/feature_new_contact_api.dart';
import 'package:localization_api/localization_api.dart';

import 'src/screen/new_contact/new_contact_router.dart';
import 'src/screen/new_contact/new_contact_screen_factory.dart';

export 'src/screen/new_contact/new_contact_router.dart';

class NewContactFeature implements INewContactFeatureApi {
  NewContactFeature({
    required NewContactFeatureDependencies dependencies,
  }) : _dependencies = dependencies;

  final NewContactFeatureDependencies _dependencies;
  late final NewContactScreenFactory _newContactScreenFactory =
      NewContactScreenFactory(dependencies: _dependencies);

  @override
  INewContactScreenFactory get newContactScreenFactory =>
      _newContactScreenFactory;
}

class NewContactFeatureDependencies {
  NewContactFeatureDependencies({
    required this.connectionStateProvider,
    required this.stringsProvider,
    required this.router,
    required this.blockInteractionManager,
    required this.fileRepository,
    required this.userRepository,
    required this.contactsManager,
    required this.errorTransformer,
  });

  final IConnectionStateProvider connectionStateProvider;
  final IStringsProvider stringsProvider;
  final INewContactRouter router;
  final IBlockInteractionManager blockInteractionManager;
  final IFileRepository fileRepository;
  final IUserRepository userRepository;
  final IContactsManager contactsManager;
  final IErrorTransformer errorTransformer;
}
