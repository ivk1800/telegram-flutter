import 'package:chat_actions_panel/chat_actions_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class ChatActionPanelFactory implements IChatActionPanelFactory {
  ChatActionPanelFactory({
    required ILocalizationManager localizationManager,
  }) : _localizationManager = localizationManager;

  final ILocalizationManager _localizationManager;

  @override
  Widget create(PanelState state) {
    return MultiProvider(
      providers: <Provider<dynamic>>[
        Provider<ILocalizationManager>.value(
          value: _localizationManager,
        ),
      ],
      child: _PanelContainer(state: state),
    );
  }
}

class _PanelContainer extends StatelessWidget {
  const _PanelContainer({
    Key? key,
    required this.state,
  }) : super(key: key);

  final PanelState state;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: _panelHeight + 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Divider(height: 1),
          state.map(
            join: (Join value) {
              return _Join(state: value);
            },
            empty: (Empty state) {
              return const SizedBox.shrink();
            },
            channelSubscriber: (ChannelSubscriber state) {
              return _ChannelSubscriber(state: state);
            },
            writer: (Writer state) {
              return _Writer(state: state);
            },
          ),
          // textButton()
          // buildRow()
        ],
      ),
    );
  }
}

class _ChannelSubscriber extends StatelessWidget {
  const _ChannelSubscriber({
    Key? key,
    required this.state,
  }) : super(key: key);

  final ChannelSubscriber state;

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();

    return TextButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, _panelHeight),
      ),
      onPressed: () {},
      child: Text(
        state.isMuted
            ? localizationManager.getString('ChannelUnmute')
            : localizationManager.getString('ChannelMute'),
      ),
    );
  }
}

class _Join extends StatelessWidget {
  const _Join({
    Key? key,
    required this.state,
  }) : super(key: key);

  final Join state;

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager = context.read();

    return TextButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, _panelHeight),
      ),
      onPressed: () {},
      child: Text(localizationManager.getString('ChannelJoin')),
    );
  }
}

class _Writer extends StatelessWidget {
  const _Writer({
    Key? key,
    required this.state,
  }) : super(key: key);

  final Writer state;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const SizedBox(width: 8),
        SizedBox(
          height: _panelHeight,
          child: IconButton(
            icon: const Icon(Icons.circle),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 8),
        const Flexible(
          child: TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Message',
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: _panelHeight,
          child: IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {},
          ),
        ),
        SizedBox(
          height: _panelHeight,
          child: IconButton(
            icon: const Icon(Icons.mic_rounded),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

const double _panelHeight = 50;
