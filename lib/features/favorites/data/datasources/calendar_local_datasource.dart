import 'package:assignment2/features/favorites/domain/entities/calendar_selection.dart';

/// Local in-memory calendar data (replace with SharedPreferences / Isar later).
abstract class CalendarLocalDataSource {
  CalendarSelection get selection;

  void updateSelection(CalendarSelection value);
}

class CalendarLocalDataSourceImpl implements CalendarLocalDataSource {
  CalendarLocalDataSourceImpl() : _selection = CalendarSelection.initial();

  CalendarSelection _selection;

  @override
  CalendarSelection get selection => _selection;

  @override
  void updateSelection(CalendarSelection value) {
    _selection = value;
  }
}
