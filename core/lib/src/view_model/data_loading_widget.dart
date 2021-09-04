import 'package:flutter/material.dart';

import 'data_loading_handler_mixin.dart';
import 'data_loading_widget_delegate.dart';

class DataLoadingWidget<D, VM extends DataLoadingHandlerMixin<D>>
    extends StatelessWidget {
  const DataLoadingWidget({
    Key? key,
    required this.delegate,
    required this.viewModel,
  }) : super(key: key);

  final IDataLoadingWidgetDelegate<D> delegate;

  final VM viewModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: _buildRootWidget(context),
        );
      },
    );
  }

  StreamBuilder<DataLoadingState<D>> _buildRootWidget(BuildContext context) {
    return StreamBuilder<DataLoadingState<D>>(
      stream: viewModel.loadingState(),
      builder:
          (BuildContext context, AsyncSnapshot<DataLoadingState<D>> snapshot) {
        if (!snapshot.hasData) {
          return delegate.buildLoadingWidget(context);
        }

        final DataLoadingState<D> state = snapshot.data!;

        if (state is LoadingState) {
          return delegate.buildLoadingWidget(context);
        } else if (state is ErrorState<D>) {
          return delegate.buildErrorWidget(context, viewModel, state.error);
        } else if (state is SuccessState<D>) {
          return delegate.buildSuccessWidget(context, state.data);
        }
        throw StateError('unknown state$state');
      },
    );
  }
}
