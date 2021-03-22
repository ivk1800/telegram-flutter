import 'package:flutter/widgets.dart';

import 'data_loading_handler_mixin.dart';

abstract class IDataLoadingWidgetDelegate<D> {
  Widget buildErrorWidget(
      BuildContext context, DataLoadingHandlerMixin<D> loading, dynamic error);

  Widget buildLoadingWidget(BuildContext context);

  Widget buildSuccessWidget(BuildContext context, D data);
}
