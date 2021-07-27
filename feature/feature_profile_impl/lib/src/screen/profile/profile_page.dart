import 'package:feature_chat_header_info_api/feature_chat_header_info_api.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_bloc.dart';
import 'package:feature_profile_impl/src/screen/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Center(
      child: Text('UserProfileScreen ${state.runtimeType}'),
    );
  }

  Widget _buildHeader(BuildContext context, ChatHeaderInfo info) {
    final IChatHeaderInfoFactory chatHeaderInfoFactory = Provider.of(context);
    return chatHeaderInfoFactory.create(
      context: context,
      info: ChatHeaderInfo(
        photoId: 0,
        title: 'title',
        chatId: 0,
        subtitle: 'subtitle',
      ),
    );
  }
}
