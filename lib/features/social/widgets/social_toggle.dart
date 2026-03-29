import 'package:chess_app/features/social/cubit/social_cubit.dart';
import 'package:chess_app/features/social/cubit/social_state.dart';
import 'package:chess_app/features/social/enums/social_tabs_enum.dart';
import 'package:chess_app/presentation/widgets/tab_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialToggle extends StatelessWidget {
  const SocialToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final activeTab = context.watch<SocialCubit>().state.currentTab;
    final cubit = context.read<SocialCubit>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          TabToggle(
            label: "Friends",
            isActive: activeTab == SocialTabs.friends,
            onTap: cubit.switchToFriends,
            activeColor: colorScheme.primary,
            inActiveColor: theme.cardTheme.color!,
          ),
          SizedBox(width: 8),
          TabToggle(
            label: "Global",
            isActive: activeTab == SocialTabs.global,
            onTap: cubit.switchToGlobal,
            activeColor: colorScheme.primary,
            inActiveColor: theme.cardTheme.color!,
          ),
        ],
      ),
    );
  }
}
