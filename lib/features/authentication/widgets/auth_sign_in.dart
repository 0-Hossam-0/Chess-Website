import 'package:chess_app/features/authentication/widgets/auth_action_button.dart';
import 'package:chess_app/features/authentication/widgets/auth_social_button.dart';
import 'package:chess_app/features/authentication/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class AuthSignIn extends StatelessWidget {
  const AuthSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email"),
        SizedBox(height: 5),
        AuthTextField(hintText: "you@example.com", obscureText: false),
        SizedBox(height: 10),
        Text("Password"),
        SizedBox(height: 5),
        AuthTextField(hintText: "••••••", obscureText: false),
        SizedBox(height: 30),
        AuthActionButton(text: "Sign In", onPressed: () => {}),
        SizedBox(height: 10),
        Center(
          child: Text(
            "or continue with",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
        SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3,
          children: [
            AuthSocialButton(
              text: "Google",
              icon: "assets/images/google_logo.png",
              onPressed: () => {},
            ),
            AuthSocialButton(
              text: "Google",
              icon: "assets/images/google_logo.png",
              onPressed: () => {},
            ),
          ],
        ),
      ],
    );
  }
}
