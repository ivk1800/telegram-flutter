import 'package:chat_list_theme/chat_list_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'unread_messages_count.dart';

class Title extends StatelessWidget {
  const Title({
    super.key,
    required this.text,
    required this.isSecret,
    required this.isVerified,
    required this.isMuted,
    required this.lastMessageDate,
    required this.isRead,
  });

  final String text;
  final bool isSecret;
  final bool isMuted;
  final bool isVerified;
  final bool? isRead;
  final String? lastMessageDate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final bool? isRead = this.isRead;
    final String? lastMessageDate = this.lastMessageDate;
    final List<Widget> widgets = <Widget>[
      _Title(
        text: text,
        isMuted: isMuted,
        isSecret: isSecret,
        isVerified: isVerified,
      ),
      if (isRead != null) ...<Widget>[
        SvgPicture.asset(
          'assets/icon/${isRead ? 'double_check' : 'check'}.svg',
          package: 'coreui',
          color: Colors.green,
        ),
        const SizedBox(width: 4),
      ],
      if (lastMessageDate != null) ...<Widget>[
        Text(
          lastMessageDate,
          style: theme.textTheme.caption!.copyWith(
            fontSize: 13,
          ),
        ),
      ],
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }
}

class SubtitleGroup extends StatelessWidget {
  const SubtitleGroup({
    super.key,
    required this.firstSubtitleText,
    required this.secondSubtitleText,
    required this.isPinned,
    required this.isMentioned,
    required this.isMuted,
    required this.unreadMessagesCount,
  });

  final String? firstSubtitleText;
  final String? secondSubtitleText;
  final bool isPinned;
  final bool isMentioned;
  final bool isMuted;
  final int unreadMessagesCount;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[];
    final List<Widget> subtitleWidgets = <Widget>[];

    final String? firstSubtitleText = this.firstSubtitleText;
    final String? secondSubtitleText = this.secondSubtitleText;
    final Widget? firstSubtitle = firstSubtitleText == null
        ? null
        : _Subtitle(
            firstSubtitle: firstSubtitleText,
            secondSubtitle: secondSubtitleText,
          );
    final Widget? secondSubtitle = secondSubtitleText == null
        ? null
        : _SecondSubtitle(
            firstSubtitle: firstSubtitleText,
            secondSubtitle: secondSubtitleText,
          );

    if (firstSubtitle != null) {
      subtitleWidgets.add(firstSubtitle);
    }

    if (secondSubtitle != null) {
      subtitleWidgets.add(secondSubtitle);
    }

    widgets.add(
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: subtitleWidgets,
        ),
      ),
    );
    if (isPinned && unreadMessagesCount == 0 && !isMentioned) {
      widgets.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: SvgPicture.asset(
            'assets/icon/pinned.svg',
            package: 'coreui',
            width: 23,
            height: 23,
            color: Colors.grey,
          ),
        ),
      );
    }

    // todo extract colors to theme
    if (isMentioned) {
      widgets.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(45),
            ),
            child: SvgPicture.asset(
              'assets/icon/mention.svg',
              package: 'coreui',
              width: 23,
              height: 23,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    if ((unreadMessagesCount > 1 && isMentioned) ||
        (!isMentioned && unreadMessagesCount > 0)) {
      if (isMentioned) {
        widgets.add(const SizedBox(width: 4));
      }
      widgets.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: UnreadMessagesCount(
            count: unreadMessagesCount,
            isMuted: isMuted,
          ),
        ),
      );
    }

    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}

class ChatCellBody extends StatelessWidget {
  const ChatCellBody({
    super.key,
    required this.title,
    required this.isSecret,
    required this.isVerified,
    required this.isMuted,
    required this.lastMessageDate,
    required this.isRead,
    required this.firstSubtitle,
    required this.secondSubtitle,
    required this.isPinned,
    required this.isMentioned,
    required this.unreadMessagesCount,
  });

  final String title;
  final bool isSecret;
  final bool isMuted;
  final bool isVerified;
  final bool? isRead;
  final String? lastMessageDate;
  final String? firstSubtitle;
  final String? secondSubtitle;
  final bool isPinned;
  final bool isMentioned;
  final int unreadMessagesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Title(
          isRead: isRead,
          lastMessageDate: lastMessageDate,
          text: title,
          isMuted: isMuted,
          isSecret: isSecret,
          isVerified: isVerified,
        ),
        const SizedBox(height: ChatCellTheme.kTitleBottomSpace),
        // _SecondRow(model: model),
        SubtitleGroup(
          firstSubtitleText: firstSubtitle,
          secondSubtitleText: secondSubtitle,
          isMentioned: isMentioned,
          isPinned: isPinned,
          isMuted: isMuted,
          unreadMessagesCount: unreadMessagesCount,
        ),
      ],
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({
    required this.firstSubtitle,
    required this.secondSubtitle,
  });

  final String firstSubtitle;
  final String? secondSubtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      firstSubtitle,
      maxLines: secondSubtitle != null ? 1 : 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).extension<ChatCellTheme>()?.subtitleStyle,
    );
  }
}

class _SecondSubtitle extends StatelessWidget {
  const _SecondSubtitle({
    required this.firstSubtitle,
    required this.secondSubtitle,
  });

  final String? firstSubtitle;
  final String secondSubtitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      secondSubtitle,
      maxLines: firstSubtitle != null ? 1 : 2,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
      style:
          Theme.of(context).extension<ChatCellTheme>()?.secondarySubtitleStyle,
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.text,
    required this.isSecret,
    required this.isVerified,
    required this.isMuted,
  });

  final String text;
  final bool isSecret;
  final bool isMuted;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    const double fontSize = 16;
    final List<Widget> widgets = <Widget>[
      if (isSecret) ...<Widget>[
        const Icon(Icons.lock, size: fontSize),
      ],
      Flexible(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).extension<ChatCellTheme>()?.titleStyle,
        ),
      ),
      if (isVerified) ...<Widget>[
        const SizedBox(width: 2),
        const Icon(Icons.verified, size: fontSize),
      ],
      if (!isVerified && isMuted) ...<Widget>[
        const SizedBox(width: 2),
        const Icon(Icons.volume_off, size: fontSize),
      ],
    ];

    return Flexible(child: Row(children: widgets));
  }
}
