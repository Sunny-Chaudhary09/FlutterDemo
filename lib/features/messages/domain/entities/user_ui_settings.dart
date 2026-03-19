import 'package:equatable/equatable.dart';

/// User-facing UI toggles for the settings / messages screen.
class UserUiSettings extends Equatable {
  final bool darkModeEnabled;

  const UserUiSettings({this.darkModeEnabled = true});

  UserUiSettings copyWith({bool? darkModeEnabled}) {
    return UserUiSettings(
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }

  @override
  List<Object?> get props => [darkModeEnabled];
}
