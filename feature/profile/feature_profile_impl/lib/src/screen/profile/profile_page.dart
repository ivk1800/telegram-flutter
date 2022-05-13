import 'package:core_arch_flutter/core_arch_flutter.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_screen_scope.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_state.dart';
import 'package:feature_profile_impl/src/screen/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:localization_api/localization_api.dart';

import 'content_interactor.dart';
import 'header_action_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel viewModel =
        ProfileScreenScope.getProfileViewModel(context);

    return StreamListener<ProfileState>(
      stream: viewModel.state,
      builder: (BuildContext context, ProfileState state) {
        return Scaffold(
          appBar: _AppBar(state: state.headerState),
          body: _Body(state: state.bodyState),
        );
      },
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    required this.state,
  });

  final HeaderState state;

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel viewModel =
        ProfileScreenScope.getProfileViewModel(context);

    return state.map(
      info: (Info value) {
        return AppBar(
          titleSpacing: 0.0,
          title: _Header(info: value.info),
          actions: <Widget>[
            _AppBarPopupMenu(
              actions: value.actions,
              onSelected: viewModel.onHeaderActionTap,
            ),
          ],
        );
      },
      loading: (_) => AppBar(),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}

class _AppBarPopupMenu extends StatelessWidget {
  const _AppBarPopupMenu({
    required this.onSelected,
    required this.actions,
  });

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
  const AppBarPopupMenuItem({super.key, required this.title});

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
  const _Body({required this.state});

  final BodyState state;

  @override
  Widget build(BuildContext context) {
    return state.map(
      loading: (_) => const Center(child: CircularProgressIndicator()),
      data: (BodyData data) => _Content(state: data),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.state,
  });

  final BodyData state;

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel viewModel =
        ProfileScreenScope.getProfileViewModel(context);

    final IStringsProvider stringsProvider =
        ProfileScreenScope.getStringProvider(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (state.content.description.isNotEmpty)
          tg.Section(
            text: stringsProvider.info,
          ),
        if (state.content.description.isNotEmpty)
          tg.TextCell(
            title: state.content.description,
          ),
        const tg.Divider(),
        tg.TextCell.toggle(
          onTap: viewModel.onNotificationTap,
          value: !state.content.isMuted,
          title: stringsProvider.notifications,
          subtitle: state.content.isMuted
              ? stringsProvider.notificationsOff
              : stringsProvider.notificationsOn,
          onChanged: (bool v) {
            viewModel.onNotificationToggleTap();
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
                    viewModel.onMessagesTap(info.type);
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
  const _Header({required this.info});

  final ChatHeaderInfo info;

  @override
  Widget build(BuildContext context) {
    final IChatHeaderInfoFactory chatHeaderInfoFactory =
        ProfileScreenScope.getChatHeaderInfoFactory(context);
    return chatHeaderInfoFactory.create(
      context: context,
      info: info,
    );
  }
}
