import 'package:assignment2/core/usecases/usecase.dart';
import 'package:assignment2/features/messages/domain/entities/user_ui_settings.dart';
import 'package:assignment2/features/messages/domain/usecases/get_user_ui_settings.dart';
import 'package:assignment2/features/messages/domain/usecases/set_dark_mode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesCubit extends Cubit<UserUiSettings> {
  MessagesCubit({
    required GetUserUiSettings getSettings,
    required SetDarkMode setDarkMode,
  })  : _getSettings = getSettings,
        _setDarkMode = setDarkMode,
        super(getSettings(const NoParams()));

  final GetUserUiSettings _getSettings;
  final SetDarkMode _setDarkMode;

  void setDarkModeEnabled(bool value) {
    _setDarkMode(value);
    emit(_getSettings(const NoParams()));
  }
}
