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

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (BuildContext context, ProfileState state) {},
          builder: (BuildContext context, ProfileState state) =>
              _Header(info: state.headerState.info),
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (BuildContext context, ProfileState state) {},
        builder: (BuildContext context, ProfileState state) =>
            _Body(state: state.bodyState),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key, required this.state}) : super(key: key);

  final BodyState state;

  @override
  Widget build(BuildContext context) {
    final ILocalizationManager localizationManager =
        Provider.of(context, listen: false);
    final ProfileBloc bloc = BlocProvider.of(context, listen: false);
    final BodyState state = this.state;
    if (state is DataBodyState) {
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
                      bloc.add(MessagesTap(type: info.type));
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

    return const Center(child: CircularProgressIndicator());
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
