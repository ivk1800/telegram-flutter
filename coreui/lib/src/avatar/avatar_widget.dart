import 'package:core_presentation/core_presentation.dart';
import 'package:coreui/coreui.dart';
import 'package:coreui/src/avatar/avatar_scope.dart';
import 'package:coreui/src/avatar/avatar_state.dart';
import 'package:coreui/src/avatar/avatar_view_model.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    required this.radius,
    required this.avatar,
    super.key,
  });

  final double radius;
  final Avatar avatar;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    final AvatarViewModel viewModel = AvatarScope.getViewModel(context);

    return StreamBuilder<AvatarState>(
      stream: viewModel.state,
      initialData: widget.avatar.map(
        simple: (SimpleAvatar value) {
          return AvatarState.abbreviation(
            abbreviation: '',
            objectId: value.objectId,
          );
        },
        savedMessages: (SavedMessagesAvatar value) =>
            const AvatarState.savedMessages(),
      ),
      builder: (BuildContext context, AsyncSnapshot<AvatarState> snapshot) {
        return snapshot.data!.map(
          thumbnail: (ThumbnailAvatarState state) {
            final double size = widget.radius * 2;
            return ClipRRect(
              // todo specify correct radius
              borderRadius: BorderRadius.circular(40.0),
              child: SizedBox(
                height: size,
                width: size,
                child: MinithumbnailWidget(
                  minithumbnail: state.thumbnail,
                ),
              ),
            );
          },
          abbreviation: (AbbreviationAvatarState state) {
            return _DefaultAvatar(
              radius: widget.radius,
              objectId: state.objectId,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    state.abbreviation,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
          file: (FileAvatarState state) {
            return CircleAvatar(
              backgroundColor: Colors.transparent,
              maxRadius: widget.radius,
              backgroundImage: FileImage(state.file),
            );
          },
          savedMessages: (SavedMessagesAvatarState value) {
            return _SavedMessages(radius: widget.radius);
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant AvatarWidget oldWidget) {
    if (widget.avatar != oldWidget.avatar) {
      AvatarScope.getViewModel(context).onNewAvatar(widget.avatar);
    }
    super.didUpdateWidget(oldWidget);
  }
}

class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar({
    required this.radius,
    required this.objectId,
    this.child,
  });

  final double radius;
  final int objectId;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: child,
      // todo extract ext
      backgroundColor: AvatarWidgetFactory
          .colors[(objectId % AvatarWidgetFactory.colors.length).abs()],
      maxRadius: radius,
    );
  }
}

class _SavedMessages extends StatelessWidget {
  const _SavedMessages({
    required this.radius,
  });

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: radius,
      child: const Icon(Icons.bookmark_outline),
    );
  }
}
