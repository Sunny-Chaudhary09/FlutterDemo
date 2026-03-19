import 'package:assignment2/core/usecases/usecase.dart';
import 'package:assignment2/features/favorites/domain/entities/calendar_selection.dart';
import 'package:assignment2/features/favorites/domain/repositories/calendar_repository.dart';

class GetCalendarSelection implements UseCase<CalendarSelection, NoParams> {
  GetCalendarSelection(this._repository);

  final CalendarRepository _repository;

  @override
  CalendarSelection call(NoParams params) => _repository.currentSelection;
}
