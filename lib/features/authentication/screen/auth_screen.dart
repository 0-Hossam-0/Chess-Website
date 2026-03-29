import 'package:chess_app/features/authentication/cubit/auth_cubit.dart';
import 'package:chess_app/features/authentication/widgets/auth_sign_in.dart';
import 'package:chess_app/features/authentication/widgets/auth_sign_up.dart';
import 'package:chess_app/features/authentication/widgets/auth_toggle.dart';
import 'package:chess_app/presentation/widgets/chess_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthCubit(), child: AuthBody());
  }
}

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomPaint(
                size: Size(150, 150),
                painter: ChessLogo(color: colorScheme.primary),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthToggle(),
                    const SizedBox(height: 40),
                    BlocBuilder<AuthCubit, AuthTab>(
                      builder: (context, state) {
                        if (state == AuthTab.signIn) {
                          return AuthSignIn();
                        } else {
                          return AuthSignUp();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
