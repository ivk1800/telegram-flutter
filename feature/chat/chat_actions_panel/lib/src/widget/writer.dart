import 'package:chat_actions_panel/src/chat_action_panel_scope.dart';
import 'package:chat_actions_panel/src/chat_actions_panel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import '../panel_state.dart';
import 'chat_action_panel.dart';

class Writer extends StatefulWidget {
  const Writer({
    super.key,
    required this.state,
  });

  final WriterState state;

  @override
  State<Writer> createState() => _WriterState();
}

class _WriterState extends State<Writer> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  late Animation<Size?> _clearIconTween;
  late AnimationController _animationController;
  bool _showSendButton = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _clearIconTween = SizeTween(begin: Size.zero, end: const Size(1, 1))
        .animate(_animationController);

    _messageController.addListener(_onTextChange);
    super.initState();
  }

  @override
  void dispose() {
    _messageController.removeListener(_onTextChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatActionsPanelViewModel viewModel =
        ChatActionPanelScope.getChatActionsPanelViewModel(context);
    final IStringsProvider stringsProvider =
        ChatActionPanelScope.getStringsProvider(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const SizedBox(width: 8),
        Flexible(
          child: TextField(
            controller: _messageController,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: stringsProvider.message,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(width: 8),
        AnimatedBuilder(
          animation: _clearIconTween,
          builder: (BuildContext context, Widget? child) {
            return Transform.scale(
              scale: _clearIconTween.value!.height,
              child: child,
            );
          },
          child: SizedBox(
            height: kPanelHeight,
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                viewModel.onSendMessage(text: _messageController.text);
                _messageController.text = '';
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _onTextChange() {
    setState(() {
      final bool _prevValue = _showSendButton;
      _showSendButton = _messageController.text.isNotEmpty;
      if (_showSendButton != _prevValue) {
        if (_showSendButton) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      }
    });
  }
}
