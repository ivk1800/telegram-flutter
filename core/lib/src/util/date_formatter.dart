import 'package:intl/intl.dart';
import 'package:jugger/jugger.dart' as j;

class DateFormatter {
  @j.inject
  DateFormatter();

  final DateFormat _lastDayDateFormat = DateFormat('HH:mm');
  final DateFormat _lastWeekDateFormat = DateFormat('MMM d');
  final DateFormat _lastYearDateFormat = DateFormat('d MMM yyyy');

  // TODO(Ivan): write tests, handle future time
  String formatChatLastMessageDate(DateTime time) {
    final DateTime now = DateTime.now();

    final Duration difference = time.difference(now);
    if (difference.inDays == 0) {
      return _lastDayDateFormat.format(time);
    } else if (difference.inDays <= 7) {
      return _lastWeekDateFormat.format(time);
    }

    return _lastYearDateFormat.format(time);
  }
}

extension DateFormatterExtensions on DateFormatter {
  String? formatChatLastMessageDateOrNull(DateTime? time) =>
      time != null ? formatChatLastMessageDate(time) : null;
}
