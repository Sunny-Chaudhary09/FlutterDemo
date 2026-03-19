import 'package:assignment2/cubit/navigation_cubit.dart';
import 'package:assignment2/screens/details_screen.dart';
import 'package:assignment2/screens/favorites_screen.dart';
import 'package:assignment2/screens/home_screen.dart';
import 'package:assignment2/screens/messages_screen.dart';
import 'package:assignment2/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Root screen with bottom navigation: Home, Details, Favorites, Messages.
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    DetailsScreen(),
    FavoritesScreen(),
    MessagesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, nav) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(
                child: SafeArea(
                  bottom: false,
                  child: IndexedStack(
                    index: nav.currentIndex,
                    children: _screens,
                  ),
                ),
              ),
              CustomBottomNavBar(
                currentIndex: nav.currentIndex,
                onTap: (index) => context.read<NavigationCubit>().setTab(index),
              ),
            ],
          ),
        );
      },
    );
  }
}
