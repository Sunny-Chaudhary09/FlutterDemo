import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// UI state for bottom navigation (tab index only — no persistence).
class NavigationState extends Equatable {
  final int currentIndex;

  const NavigationState({this.currentIndex = 0});

  NavigationState copyWith({int? currentIndex}) {
    return NavigationState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object?> get props => [currentIndex];
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void setTab(int index) {
    if (index == state.currentIndex) return;
    if (index < 0 || index > 3) return;
    emit(state.copyWith(currentIndex: index));
  }
}
