import 'package:flutter/material.dart';

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;
  final String icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerTheme = theme.dividerTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        side: BorderSide(color: dividerTheme.color ?? Colors.black, width: 1),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(width: 25, height: 25, icon),
          SizedBox(width: 10),
          Text(text, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
