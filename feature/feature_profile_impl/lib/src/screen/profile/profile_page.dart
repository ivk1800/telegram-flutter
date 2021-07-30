import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_bloc.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_event.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_state.dart';
import 'package:feature_profile_impl/src/screen/profile/content_interactor.dart';
import 'package:flutter/material.dart';
import 'package:coreui/coreui.dart' as tg;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_api/localization_api.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      final double extentAfter = scrollController.position.extentAfter;
      if (extentAfter < 200) {
        print("qwe");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (BuildContext context, ProfileState state) {},
          builder: (BuildContext context, ProfileState state) =>
              _buildHeader(context, state.headerState.info),
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (BuildContext context, ProfileState state) {},
        builder: (BuildContext context, ProfileState state) =>
            _buildBody(context, state.bodyState),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BodyState state) {
    final ILocalizationManager localizationManager =
        Provider.of(context, listen: false);
    final ProfileBloc bloc = BlocProvider.of(context, listen: false);
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
              }),
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
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const tg.Divider();
                  },
                  itemCount: state.content.sharedContent.length),
            ),
          const tg.SectionDivider(),
        ],
      );
    }

    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildHeader(BuildContext context, ChatHeaderInfo info) {
    final IChatHeaderInfoFactory chatHeaderInfoFactory = Provider.of(context);
    return chatHeaderInfoFactory.create(
      context: context,
      info: info,
    );
  }
}
