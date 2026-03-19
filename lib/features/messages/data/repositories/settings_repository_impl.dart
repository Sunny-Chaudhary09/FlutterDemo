import 'package:assignment2/features/messages/data/datasources/settings_local_datasource.dart';
import 'package:assignment2/features/messages/domain/entities/user_ui_settings.dart';
import 'package:assignment2/features/messages/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._local);

  final SettingsLocalDataSource _local;

  @override
  UserUiSettings get current => _local.settings;

  @override
  void setDarkMode(bool enabled) {
    _local.save(_local.settings.copyWith(darkModeEnabled: enabled));
  }
}
