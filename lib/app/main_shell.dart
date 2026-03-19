import 'package:assignment2/features/details/presentation/pages/details_page.dart';
import 'package:assignment2/features/favorites/presentation/pages/favorites_page.dart';
import 'package:assignment2/features/home/presentation/pages/home_page.dart';
import 'package:assignment2/features/messages/presentation/pages/messages_page.dart';
import 'package:assignment2/features/navigation/presentation/cubit/navigation_cubit.dart';
import 'package:assignment2/shared/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// App shell: bottom navigation + tab pages.
class MainShell extends StatelessWidget {
  const MainShell({super.key});

  static const List<Widget> _pages = [
    HomePage(),
    DetailsPage(),
    FavoritesPage(),
    MessagesPage(),
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
                    children: _pages,
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
