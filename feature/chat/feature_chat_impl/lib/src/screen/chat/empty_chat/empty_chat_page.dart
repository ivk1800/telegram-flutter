import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:feature_chat_impl/src/screen/chat/empty_chat/empty_chat_scope.dart';
import 'package:feature_chat_impl/src/screen/chat/empty_chat/empty_chat_view_model.dart';
import 'package:feature_chat_impl/src/screen/chat/empty_chat/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';

class EmptyChatPage extends StatelessWidget {
  const EmptyChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EmptyChatViewModel emptyChatViewModel =
        EmptyChatScope.getEmptyChatViewModel(context);

    final IStringsProvider stringsProvider =
        EmptyChatScope.getStringsProvider(context);

    return StreamListener<EmptyState>(
      stream: emptyChatViewModel.state,
      builder: (BuildContext context, EmptyState state) {
        return state.map(
          self: (Self value) {
            return Center(child: Text(stringsProvider.chatYourSelfTitle));
          },
          common: (Commmon common) {
            return Center(child: Text(stringsProvider.noMessages));
          },
        );
      },
    );
  }
}
