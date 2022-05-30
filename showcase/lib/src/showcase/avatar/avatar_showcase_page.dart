import 'package:coreui/coreui.dart' as tg;
import 'package:flutter/material.dart';
import 'package:showcase/src/showcase/avatar/avatar_showcase_repository.dart';
import 'package:showcase/src/showcase/avatar/avatar_showcase_scope.dart';

class AvatarShowcasePage extends StatefulWidget {
  const AvatarShowcasePage({super.key});

  @override
  State<AvatarShowcasePage> createState() => _AvatarShowcasePageState();
}

class _AvatarShowcasePageState extends State<AvatarShowcasePage> {
  late final Future<List<AvatarInfo>> _avatarsFuture;

  @override
  void initState() {
    _avatarsFuture =
        AvatarShowcaseScope.getAvatarsRepository(context).getAvatars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('avatar')),
      body: FutureBuilder<List<AvatarInfo>>(
        future: _avatarsFuture,
        initialData: const <AvatarInfo>[],
        builder: (
          BuildContext context,
          AsyncSnapshot<List<AvatarInfo>> snapshot,
        ) {
          final tg.AvatarWidgetFactory avatarWidgetFactory =
              AvatarShowcaseScope.getAvatarWidgetFactory(context);
          final List<AvatarInfo> avatars = snapshot.data!;
          return ListView.separated(
            itemCount: avatars.length,
            itemBuilder: (BuildContext context, int index) {
              final AvatarInfo avatarInfo = avatars[index];
              return ListTile(
                leading: avatarWidgetFactory.create(
                  context,
                  avatar: avatarInfo.avatar,
                ),
                title: Text(avatarInfo.description),
              );
            },
            separatorBuilder: (BuildContext c, _) => const Divider(),
          );
        },
      ),
    );
  }
}
