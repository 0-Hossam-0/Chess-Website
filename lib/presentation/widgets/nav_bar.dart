import 'package:chess_app/core/navigation/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.activeIndex});
  final int activeIndex;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return BottomNavigationBar(
      currentIndex: activeIndex,
      type: BottomNavigationBarType.shifting,
      unselectedItemColor: colorScheme.onPrimary,
      showUnselectedLabels: true,
      selectedItemColor: Colors.blue,
      onTap: (index) => context.read<NavigationCubit>().updateIndex(index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          activeIcon: Icon(Icons.home, color: colorScheme.secondary),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_4x4),
          activeIcon: Icon(Icons.grid_4x4, color: colorScheme.secondary),
          label: "Play",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.social_distance),
          activeIcon: Icon(Icons.social_distance, color: colorScheme.secondary),
          label: "Social",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          activeIcon: Icon(Icons.settings, color: colorScheme.secondary),
          label: "Settings",
        ),
      ],
    );
  }
}
