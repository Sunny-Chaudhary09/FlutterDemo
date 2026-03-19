import 'package:assignment2/core/usecases/usecase.dart';
import 'package:assignment2/features/messages/domain/entities/user_ui_settings.dart';
import 'package:assignment2/features/messages/domain/repositories/settings_repository.dart';

class GetUserUiSettings implements UseCase<UserUiSettings, NoParams> {
  GetUserUiSettings(this._repository);

  final SettingsRepository _repository;

  @override
  UserUiSettings call(NoParams params) => _repository.current;
}
