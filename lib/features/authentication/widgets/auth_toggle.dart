import 'package:chess_app/features/authentication/cubit/auth_cubit.dart';
import 'package:chess_app/presentation/widgets/tab_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthToggle extends StatelessWidget {
  const AuthToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final activeTab = context.watch<AuthCubit>().state;
    final cubit = context.read<AuthCubit>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final cardTheme = theme.cardTheme;
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
            label: "Sign In",
            isActive: activeTab == AuthTab.signIn,
            onTap: cubit.switchToSignIn,
            activeColor: colorScheme.primary,
            inActiveColor: cardTheme.color!,
          ),
          SizedBox(width: 5),
          TabToggle(
            label: "Sign Up",
            isActive: activeTab == AuthTab.signUp,
            onTap: cubit.switchToSignUp,
            activeColor: colorScheme.primary,
            inActiveColor: cardTheme.color!,
          ),
        ],
      ),
    );
  }
}
