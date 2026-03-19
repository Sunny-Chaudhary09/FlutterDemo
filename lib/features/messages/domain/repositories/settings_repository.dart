import 'package:assignment2/features/messages/domain/entities/user_ui_settings.dart';

abstract class SettingsRepository {
  UserUiSettings get current;

  void setDarkMode(bool enabled);
}
