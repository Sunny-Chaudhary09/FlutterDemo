import 'package:assignment2/core/usecases/usecase.dart';
import 'package:assignment2/features/favorites/domain/entities/calendar_selection.dart';
import 'package:assignment2/features/favorites/domain/usecases/get_calendar_selection.dart';
import 'package:assignment2/features/favorites/domain/usecases/go_to_next_month.dart';
import 'package:assignment2/features/favorites/domain/usecases/go_to_previous_month.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<CalendarSelection> {
  FavoritesCubit({
    required GetCalendarSelection getSelection,
    required GoToPreviousMonth goToPreviousMonth,
    required GoToNextMonth goToNextMonth,
  })  : _getSelection = getSelection,
        _goToPreviousMonth = goToPreviousMonth,
        _goToNextMonth = goToNextMonth,
        super(getSelection(const NoParams()));

  final GetCalendarSelection _getSelection;
  final GoToPreviousMonth _goToPreviousMonth;
  final GoToNextMonth _goToNextMonth;

  void previousMonth() {
    _goToPreviousMonth(const NoParams());
    emit(_getSelection(const NoParams()));
  }

  void nextMonth() {
    _goToNextMonth(const NoParams());
    emit(_getSelection(const NoParams()));
  }
}
