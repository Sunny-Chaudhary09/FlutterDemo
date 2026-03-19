import 'package:assignment2/features/favorites/data/datasources/calendar_local_datasource.dart';
import 'package:assignment2/features/favorites/domain/entities/calendar_selection.dart';
import 'package:assignment2/features/favorites/domain/repositories/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  CalendarRepositoryImpl(this._local);

  final CalendarLocalDataSource _local;

  @override
  CalendarSelection get currentSelection => _local.selection;

  @override
  void goToNextMonth() {
    final m = _local.selection.focusedMonth;
    _local.updateSelection(
      _local.selection.copyWith(focusedMonth: DateTime(m.year, m.month + 1)),
    );
  }

  @override
  void goToPreviousMonth() {
    final m = _local.selection.focusedMonth;
    _local.updateSelection(
      _local.selection.copyWith(focusedMonth: DateTime(m.year, m.month - 1)),
    );
  }
}
