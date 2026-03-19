import 'package:assignment2/features/favorites/data/datasources/calendar_local_datasource.dart';
import 'package:assignment2/features/favorites/data/repositories/calendar_repository_impl.dart';
import 'package:assignment2/features/favorites/domain/repositories/calendar_repository.dart';
import 'package:assignment2/features/favorites/domain/usecases/get_calendar_selection.dart';
import 'package:assignment2/features/favorites/domain/usecases/go_to_next_month.dart';
import 'package:assignment2/features/favorites/domain/usecases/go_to_previous_month.dart';
import 'package:assignment2/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:assignment2/features/messages/data/datasources/settings_local_datasource.dart';
import 'package:assignment2/features/messages/data/repositories/settings_repository_impl.dart';
import 'package:assignment2/features/messages/domain/repositories/settings_repository.dart';
import 'package:assignment2/features/messages/domain/usecases/get_user_ui_settings.dart';
import 'package:assignment2/features/messages/domain/usecases/set_dark_mode.dart';
import 'package:assignment2/features/messages/presentation/cubit/messages_cubit.dart';

/// Simple service locator for Clean Architecture wiring (no get_it required).
class Injector {
  Injector._();

  static late final CalendarLocalDataSource _calendarLocal;
  static late final CalendarRepository _calendarRepository;
  static late final SettingsLocalDataSource _settingsLocal;
  static late final SettingsRepository _settingsRepository;

  /// Call once before [runApp].
  static void init() {
    _calendarLocal = CalendarLocalDataSourceImpl();
    _calendarRepository = CalendarRepositoryImpl(_calendarLocal);
    _settingsLocal = SettingsLocalDataSourceImpl();
    _settingsRepository = SettingsRepositoryImpl(_settingsLocal);
  }

  static FavoritesCubit createFavoritesCubit() {
    final repo = _calendarRepository;
    return FavoritesCubit(
      getSelection: GetCalendarSelection(repo),
      goToPreviousMonth: GoToPreviousMonth(repo),
      goToNextMonth: GoToNextMonth(repo),
    );
  }

  static MessagesCubit createMessagesCubit() {
    final repo = _settingsRepository;
    return MessagesCubit(
      getSettings: GetUserUiSettings(repo),
      setDarkMode: SetDarkMode(repo),
    );
  }
}
