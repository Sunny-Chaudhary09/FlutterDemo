import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesState extends Equatable {
  final bool darkModeOn;

  const MessagesState({this.darkModeOn = true});

  MessagesState copyWith({bool? darkModeOn}) {
    return MessagesState(darkModeOn: darkModeOn ?? this.darkModeOn);
  }

  @override
  List<Object?> get props => [darkModeOn];
}

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(const MessagesState());

  void setDarkMode(bool value) => emit(state.copyWith(darkModeOn: value));
}
