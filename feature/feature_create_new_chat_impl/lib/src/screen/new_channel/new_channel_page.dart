import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'new_channel.dart';

class NewChannelPage extends StatelessWidget {
  const NewChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        CreateNewChannelScreenScore.getStringsProvider(context);

    final NewChannelWidgetModel newChannelWidgetModel =
        CreateNewChannelScreenScore.getNewChannelWidgetModel(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const CircleAvatar(radius: 32),
            const SizedBox(width: 16),
            Flexible(
              child: TextField(
                autofocus: true,
                controller: newChannelWidgetModel.channelNameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: stringsProvider.enterChannelName,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.tag_faces),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: newChannelWidgetModel.channelDescriptionController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            hintText: stringsProvider.descriptionPlaceholder,
          ),
        ),
        const SizedBox(height: 8),
        Text(stringsProvider.descriptionInfo)
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final IStringsProvider stringsProvider =
        CreateNewChannelScreenScore.getStringsProvider(context);

    final NewChannelWidgetModel newChannelController =
        CreateNewChannelScreenScore.getNewChannelWidgetModel(context);

    return AppBar(
      title: Text(stringsProvider.newChannel),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: newChannelController.submitTap,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
