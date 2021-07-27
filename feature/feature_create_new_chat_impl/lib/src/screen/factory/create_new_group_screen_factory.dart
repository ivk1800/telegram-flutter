import 'package:create_new_chat_impl/feature_create_new_chat_impl.dart';
import 'package:feature_create_new_chat_api/feature_create_new_chat_api.dart';
import 'package:flutter/widgets.dart';

class CreateNewGroupScreenFactory implements ICreateNewGroupScreenFactory {
  CreateNewGroupScreenFactory(
      {required ICreateNewChatFeatureDependencies dependencies})
      : _dependencies = dependencies;

  final ICreateNewChatFeatureDependencies _dependencies;

  @override
  Widget create(BuildContext context) {
    return const Center(
      child: Text('CreateNewGroupScreen'),
    );
  }
}
