import 'package:core_presentation/core_presentation.dart' as cp;
import 'package:coreui/coreui.dart';
import 'package:coreui/src/avatar/avatar_scope.dart';
import 'package:coreui/src/avatar/avatar_state.dart';
import 'package:coreui/src/avatar/avatar_view_model.dart';
import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  const Avatar({
    required this.radius,
    required this.avatar,
    required this.borderRadius,
    super.key,
  });

  final double radius;
  final cp.Avatar avatar;
  final BorderRadiusGeometry borderRadius;

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    final AvatarViewModel viewModel = AvatarScope.getViewModel(context);

    return StreamBuilder<AvatarState>(
      stream: viewModel.state,
      initialData: widget.avatar.map(
        simple: (cp.SimpleAvatar value) {
          return AvatarState.abbreviation(
            abbreviation: '',
            objectId: value.objectId,
          );
        },
        savedMessages: (cp.SavedMessagesAvatar value) =>
            const AvatarState.savedMessages(),
      ),
      builder: (BuildContext context, AsyncSnapshot<AvatarState> snapshot) {
        return snapshot.data!.map(
          thumbnail: (ThumbnailAvatarState state) {
            return _Thumbnail(
              radius: widget.radius,
              state: state,
              borderRadius: widget.borderRadius,
            );
          },
          abbreviation: (AbbreviationAvatarState state) {
            return _Abbreviation(
              radius: widget.radius,
              state: state,
              borderRadius: widget.borderRadius,
            );
          },
          file: (FileAvatarState state) {
            return _File(
              radius: widget.radius,
              state: state,
              borderRadius: widget.borderRadius,
            );
          },
          savedMessages: (SavedMessagesAvatarState value) {
            return _SavedMessages(
              radius: widget.radius,
              borderRadius: widget.borderRadius,
            );
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant Avatar oldWidget) {
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
    required this.borderRadius,
    this.child,
  });

  final double radius;
  final BorderRadiusGeometry borderRadius;
  final int objectId;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return _BaseAvatar(
      child: child,
      // todo extract ext
      backgroundColor: AvatarWidgetFactory
          .colors[(objectId % AvatarWidgetFactory.colors.length).abs()],
      radius: radius,
      borderRadius: borderRadius,
    );
  }
}

class _SavedMessages extends StatelessWidget {
  const _SavedMessages({
    required this.radius,
    required this.borderRadius,
  });

  final double radius;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle textStyle = theme.primaryTextTheme.titleMedium!;
    return _BaseAvatar(
      radius: radius,
      borderRadius: borderRadius,
      child: Icon(Icons.bookmark_outline, color: textStyle.color),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({
    required this.state,
    required this.radius,
    required this.borderRadius,
  });

  final BorderRadiusGeometry borderRadius;
  final ThumbnailAvatarState state;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final double size = radius * 2;
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: size,
        width: size,
        child: Minithumbnail(
          minithumbnail: state.thumbnail,
        ),
      ),
    );
  }
}

class _Abbreviation extends StatelessWidget {
  const _Abbreviation({
    required this.state,
    required this.radius,
    required this.borderRadius,
  });

  final AbbreviationAvatarState state;
  final double radius;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return _DefaultAvatar(
      radius: radius,
      borderRadius: borderRadius,
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
  }
}

class _File extends StatelessWidget {
  const _File({
    required this.state,
    required this.radius,
    required this.borderRadius,
  });

  final FileAvatarState state;
  final double radius;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return _BaseAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      borderRadius: borderRadius,
      backgroundImage: FileImage(state.file),
    );
  }
}

class _BaseAvatar extends StatelessWidget {
  const _BaseAvatar({
    required this.radius,
    required this.borderRadius,
    this.backgroundImage,
    this.backgroundColor,
    this.child,
  });

  final double radius;
  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final Widget? child;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    final double diameter = radius * 2;
    final ThemeData theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(
        minHeight: diameter,
        minWidth: diameter,
        maxWidth: diameter,
        maxHeight: diameter,
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor ?? theme.primaryColor,
        image: backgroundImage != null
            ? DecorationImage(
                image: backgroundImage!,
                fit: BoxFit.cover,
              )
            : null,
        // shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
