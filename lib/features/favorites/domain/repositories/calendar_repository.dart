import 'package:assignment2/features/favorites/domain/entities/calendar_selection.dart';

/// Contract for reading/updating calendar selection (data layer implements this).
abstract class CalendarRepository {
  CalendarSelection get currentSelection;

  void goToPreviousMonth();

  void goToNextMonth();
}
