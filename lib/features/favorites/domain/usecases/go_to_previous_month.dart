import 'package:assignment2/core/usecases/usecase.dart';
import 'package:assignment2/features/favorites/domain/repositories/calendar_repository.dart';

class GoToPreviousMonth implements UseCase<void, NoParams> {
  GoToPreviousMonth(this._repository);

  final CalendarRepository _repository;

  @override
  void call(NoParams params) => _repository.goToPreviousMonth();
}
