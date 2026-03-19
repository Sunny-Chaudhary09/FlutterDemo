import 'package:assignment2/features/messages/domain/repositories/settings_repository.dart';

class SetDarkMode {
  SetDarkMode(this._repository);

  final SettingsRepository _repository;

  void call(bool enabled) => _repository.setDarkMode(enabled);
}
