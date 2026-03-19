import 'package:assignment2/core/usecases/usecase.dart';
import 'package:assignment2/features/favorites/domain/repositories/calendar_repository.dart';

class GoToNextMonth implements UseCase<void, NoParams> {
  GoToNextMonth(this._repository);

  final CalendarRepository _repository;

  @override
  void call(NoParams params) => _repository.goToNextMonth();
}
