import 'package:block_interaction_api/block_interaction_api.dart';
import 'package:core_arch/core_arch.dart';
import 'package:error_transformer_api/error_transformer_api.dart';
import 'package:feature_change_bio_impl/src/change_bio_feature_dependencies.dart';
import 'package:jugger/jugger.dart' as j;

@j.singleton
@j.disposable
class ChangeBioViewModel extends BaseViewModel {
  @j.inject
  ChangeBioViewModel({
    required IBlockInteractionManager blockInteractionManager,
    required IErrorTransformer errorTransformer,
    required IChangeBioRouter router,
  })  : _blockInteractionManager = blockInteractionManager,
        _errorTransformer = errorTransformer,
        _router = router;

  // ignore: unused_field
  final IBlockInteractionManager _blockInteractionManager;
  // ignore: unused_field
  final IErrorTransformer _errorTransformer;
  // ignore: unused_field
  final IChangeBioRouter _router;
}
