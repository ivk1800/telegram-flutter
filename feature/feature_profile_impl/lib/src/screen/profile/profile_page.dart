import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_bloc.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_event.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_state.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

import 'bloc/header_action_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (BuildContext context, ProfileState state) {},
        builder: (BuildContext context, ProfileState state) =>
            _Body(state: state.bodyState),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (BuildContext context, ProfileState state) {},
      builder: (BuildContext context, ProfileState state) {
        return AppBar(
          titleSpacing: 0.0,
          title: _Header(info: state.headerState.info),
          actions: <Widget>[
            _AppBarPopupMenu(
              actions: state.headerState.actions,
              onSelected: (HeaderAction action) {
                context
                    .read<ProfileBloc>()
                    .add(ProfileEvent.headerActionTap(action));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _AppBarPopupMenu extends StatelessWidget {
  const _AppBarPopupMenu({
    Key? key,
    required this.onSelected,
    required this.actions,
  }) : super(key: key);

  final List<HeaderActionData> actions;
  final PopupMenuItemSelected<HeaderAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<HeaderAction>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => actions
          .map(
            (HeaderActionData e) => PopupMenuItem<HeaderAction>(
              value: e.action,
              child: AppBarPopupMenuItem(
                title: e.label,
              ),
            ),
          )
          .toList(),
    );
  }
}

// todo same in settings page, extract common widget
class AppBarPopupMenuItem extends StatelessWidget {
  const AppBarPopupMenuItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.circle),
      title: Text(title),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.state}) : super(key: key);

  final BodyState state;

  @override
  Widget build(BuildContext context) {
    final ProfileBloc bloc = BlocProvider.of(context, listen: false);
    final BodyState state = this.state;
    return state.map(
      loading: (Loading value) =>
          const Center(child: CircularProgressIndicator()),
      data: (Data state) => _Content(state: state, bloc: bloc),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
    required this.bloc,
    required this.state,
  }) : super(key: key);

  final Data state;
  final ProfileBloc bloc;

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager =
        Provider.of(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (state.content.description.isNotEmpty)
          tg.Section(
            text: localizationManager.getString('Info'),
          ),
        if (state.content.description.isNotEmpty)
          tg.TextCell(
            title: state.content.description,
          ),
        const tg.Divider(),
        tg.TextCell.toggle(
          onTap: () {
            bloc.add(const NotificationTap());
          },
          value: !state.content.isMuted,
          title: localizationManager.getString('Notifications'),
          subtitle: state.content.isMuted
              ? localizationManager.getString('NotificationsOff')
              : localizationManager.getString('NotificationsOn'),
          onChanged: (bool v) {
            bloc.add(const NotificationToggleTap());
          },
        ),
        if (state.content.sharedContent.isNotEmpty) const tg.SectionDivider(),
        if (state.content.sharedContent.isNotEmpty)
          Expanded(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final SharedContentInfo info =
                    state.content.sharedContent[index];
                return tg.TextCell.textValue(
                  onTap: () {
                    bloc.add(ProfileEvent.messagesTap(info.type));
                  },
                  title: info.title,
                  value: '${info.count}',
                  leading: const Icon(
                    Icons.circle,
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const tg.Divider();
              },
              itemCount: state.content.sharedContent.length,
            ),
          ),
        const tg.SectionDivider(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key, required this.info}) : super(key: key);

  final ChatHeaderInfo info;

  @override
  Widget build(BuildContext context) {
    final IChatHeaderInfoFactory chatHeaderInfoFactory = Provider.of(context);
    return chatHeaderInfoFactory.create(
      context: context,
      info: info,
    );
  }
}
