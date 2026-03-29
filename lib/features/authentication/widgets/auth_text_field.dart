import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
  });

  final bool obscureText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dividerTheme = theme.dividerTheme;
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF878A93)),
        isDense: true,
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.2),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: dividerTheme.color ?? Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
      ),
    );
  }
}
