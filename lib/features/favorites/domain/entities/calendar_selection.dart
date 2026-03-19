import 'package:equatable/equatable.dart';

/// Stay / calendar selection shown on the Favorites (date picker) flow.
class CalendarSelection extends Equatable {
  final DateTime focusedMonth;
  final DateTime rangeStart;
  final DateTime rangeEnd;

  const CalendarSelection({
    required this.focusedMonth,
    required this.rangeStart,
    required this.rangeEnd,
  });

  factory CalendarSelection.initial() {
    return CalendarSelection(
      focusedMonth: DateTime(2022, 10),
      rangeStart: DateTime(2022, 10, 24),
      rangeEnd: DateTime(2022, 10, 26),
    );
  }

  CalendarSelection copyWith({
    DateTime? focusedMonth,
    DateTime? rangeStart,
    DateTime? rangeEnd,
  }) {
    return CalendarSelection(
      focusedMonth: focusedMonth ?? this.focusedMonth,
      rangeStart: rangeStart ?? this.rangeStart,
      rangeEnd: rangeEnd ?? this.rangeEnd,
    );
  }

  static const _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  int get nightCount {
    final days = rangeEnd.difference(rangeStart).inDays;
    return days < 1 ? 1 : days;
  }

  String get stayTitle => nightCount == 1 ? '1-night stay' : '$nightCount-night stay';

  String get staySubtitle {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final s = rangeStart;
    final e = rangeEnd;
    final ds = dayNames[s.weekday - 1];
    final de = dayNames[e.weekday - 1];
    final ms = _monthNames[s.month - 1].substring(0, 3);
    final me = _monthNames[e.month - 1].substring(0, 3);
    return '$ds, $ms ${s.day} - $de, $me ${e.day}';
  }

  String get bottomDateLine {
    final s = rangeStart;
    final e = rangeEnd;
    final ms = _monthNames[s.month - 1].substring(0, 3);
    final me = _monthNames[e.month - 1].substring(0, 3);
    if (s.month == e.month) {
      return '$ms ${s.day} - ${e.day}';
    }
    return '$ms ${s.day} - $me ${e.day}';
  }

  String monthYearLabel() =>
      '${_monthNames[focusedMonth.month - 1]} ${focusedMonth.year}';

  bool isInSelectedRange(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    final a = DateTime(rangeStart.year, rangeStart.month, rangeStart.day);
    final b = DateTime(rangeEnd.year, rangeEnd.month, rangeEnd.day);
    return !d.isBefore(a) && !d.isAfter(b);
  }

  @override
  List<Object?> get props => [focusedMonth, rangeStart, rangeEnd];
}
