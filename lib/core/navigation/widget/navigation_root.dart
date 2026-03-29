import 'package:chess_app/features/home/screen/home_screen.dart';
import 'package:chess_app/features/social/screen/social_screen.dart';
import 'package:chess_app/core/navigation/cubit/navigation_cubit.dart';
import 'package:chess_app/presentation/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationRoot extends StatelessWidget {
  const NavigationRoot({super.key});
  static const List<Widget> _pages = [
    Center(child: HomeScreen()),
    Center(child: Text("Play Chess")),
    Center(child: SocialScreen()),
    Center(child: Text("Settings")),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, activeIndex) {
          return Scaffold(
            // appBar: const ChessAppBar(),
            body: IndexedStack(index: activeIndex, children: _pages),
            bottomNavigationBar: NavBar(activeIndex: activeIndex),
          );
        },
      ),
    );
  }
}
