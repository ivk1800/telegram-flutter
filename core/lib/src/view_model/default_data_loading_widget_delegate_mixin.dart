import 'package:flutter/material.dart';
import 'data_loading_handler_mixin.dart';
import 'data_loading_widget_delegate.dart';

mixin DefaultDataLoadingWidgetDelegateMixin<D>
    implements IDataLoadingWidgetDelegate<D> {
  @override
  Widget buildErrorWidget(
      BuildContext context, DataLoadingHandlerMixin<D> loading, dynamic error) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text('Error'),
        Text(error.toString()),
        MaterialButton(
          onPressed: loading.repeatLoadingButtonClicked,
          child: const Text('retry'),
        )
      ],
    ));
  }

  @override
  Widget buildLoadingWidget(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
