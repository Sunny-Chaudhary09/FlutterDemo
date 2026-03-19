import 'package:assignment2/features/messages/domain/entities/user_ui_settings.dart';

abstract class SettingsLocalDataSource {
  UserUiSettings get settings;

  void save(UserUiSettings value);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  SettingsLocalDataSourceImpl() : _settings = const UserUiSettings();

  UserUiSettings _settings;

  @override
  UserUiSettings get settings => _settings;

  @override
  void save(UserUiSettings value) {
    _settings = value;
  }
}
